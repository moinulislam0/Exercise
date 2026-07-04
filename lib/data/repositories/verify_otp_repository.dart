import 'package:touralie33_fo222668a7688/data/sources/remote/verify_email_servicce.dart';

class VerifyOtpRepository {
  VerifyEmailServicce resource;
  VerifyOtpRepository({required this.resource});

  Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String token,
  }) async {
    return resource.verifyEmail(email: email, token: token);
  }
}
