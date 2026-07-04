import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';

class VerifyEmailApiService {
  ApiClient apiClient;
  VerifyEmailApiService({required this.apiClient});
  Future<bool> verifyOtp({required String email, required String otp}) async {
  try {
    final body = {"email": email, "token": otp};

    final dynamic response = await apiClient.postRequest(
      body: body,
      endpoints: ApiEndpoints.verifyOtp,
    );
   
    if (response['success'] == true || response['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    rethrow;
  }
}
}