import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/repositories/forgotPass_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/auth_api_service.dart';

class ForgotState {
  final bool isLoading;
  final String? errorMessage; 

  ForgotState({required this.isLoading, this.errorMessage});

  ForgotState copyWith({bool? isLoading, String? errorMessage}) {
    return ForgotState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}


class ForgotPasswordProvider extends StateNotifier<ForgotState>{
 final ForgotPassRepository repository;
  ForgotPasswordProvider({required this.repository}):super(ForgotState(isLoading: false));

  Future<bool>forgotPass({required String email})async{
      state = state.copyWith(isLoading: true,errorMessage: null);
    try{
    
      final response = await repository.forgotPass(email: email);
      state = state.copyWith(isLoading: false,);
      return response;
    }
    catch(e){
    state = state.copyWith(
      isLoading: false,
      errorMessage: ErrorHandle.formatErrorMessage(e),
    );
      return false;
    }
  }
}



  final forgotPasswordProvider = StateNotifierProvider<ForgotPasswordProvider,ForgotState>((ref){
  return ForgotPasswordProvider(repository: ForgotPassRepository(remoteSource: AuthApiService(apiClient:ApiClient() )));
});
