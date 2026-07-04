import 'package:riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/repositories/verify_email_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/verify_email_api_service.dart';

class EmailOtpState{
  final bool loading;
  final String? isSuccess;
    final String? errorMessage; 
  EmailOtpState({required this.loading,this.isSuccess,this.errorMessage});

 EmailOtpState copyWith({bool ? loading,String? isSuccess,String? errorMessage}){
  return EmailOtpState(loading: loading ?? this.loading, isSuccess: isSuccess ?? "",errorMessage:errorMessage ??"");
 }
}


class EmailOtpVerifyProvider extends StateNotifier<EmailOtpState>{
    VerifyEmailRepository repository;

    EmailOtpVerifyProvider({required this.repository}):super(EmailOtpState(loading:false ,));

    Future<bool>verifyOtpEmail({required String email,required String otp})async{
      state = state.copyWith(loading: true,isSuccess: null);
      try{
       final response = await repository.verifyOtp(email: email, otp: otp);
       if (response == true) {
        
        state = state.copyWith(loading: false, isSuccess: "Success");
        return true;
      } else {
       
        state = state.copyWith(loading: false, errorMessage: "Invalid OTP code");
        return false;
      }
    } catch (e) {
   
      state = state.copyWith(
        loading: false,
        errorMessage: ErrorHandle.formatErrorMessage(e),
      );
      return false;
    }
    }

}

final emailOtpVerifyProvider = StateNotifierProvider<EmailOtpVerifyProvider,EmailOtpState>((ref){
  return EmailOtpVerifyProvider(
     repository: VerifyEmailRepository(
      remoteSource:VerifyEmailApiService(apiClient: ApiClient()),
    ),
  );
});
