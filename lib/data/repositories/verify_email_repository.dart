import 'package:touralie33_fo222668a7688/data/sources/remote/verify_email_api_service.dart';

class VerifyEmailRepository {
   final VerifyEmailApiService remoteSource;
   VerifyEmailRepository({required this.remoteSource});

   Future<bool>verifyOtp({required String email,required String otp})async{
    return await remoteSource.verifyOtp(email: email, otp: otp);
   }
   
}