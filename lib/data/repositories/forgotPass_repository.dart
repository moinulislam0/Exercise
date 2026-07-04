
import 'package:touralie33_fo222668a7688/data/sources/remote/auth_api_service.dart';

class ForgotPassRepository {
  final AuthApiService remoteSource;

  ForgotPassRepository({required this.remoteSource});

  Future<bool> forgotPass({required String email}) async {
    return remoteSource.forgotPass(email: email);
  }
}
