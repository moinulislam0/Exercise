import 'package:touralie33_fo222668a7688/data/sources/remote/reset_password_api_service.dart';

class ResetpasswordReposityory {
  ResetPasswordApiService resource;
  ResetpasswordReposityory({required this.resource});

  Future<bool>resetPassword({required String email,required String pass,required String token})async{
    return await resource.resetPass(email: email, pass: pass, token: token);
  }
}