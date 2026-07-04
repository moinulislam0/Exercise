
import '../sources/remote/auth_api_service.dart';

class AuthRepository {
  final AuthApiService remoteSource;
  AuthRepository({required this.remoteSource});
  Future<bool> register({required String name,required String email,required String password,required String weight,required String height,required String gender,required String dateOfBirth,required String personalization,required String type})async {
   return await remoteSource.register(email: email,name: name,password: password,weight: weight,height: height,personalization: personalization,type: type,gender: gender,dateOfBirth: dateOfBirth);
  }
  Future<bool> login({
    required String email,
    required String password,
    String? fcmToken,
  })async {
   return await remoteSource.login(
     email: email,
     password: password,
     fcmToken: fcmToken,
   );
  }

  Future<bool> logout() async {
    return await remoteSource.logout();
  }
  
}
