import 'package:dio/dio.dart';

import '../../../core/network/api_clients.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/error_handle.dart';

class ChangePasswordApiService {
  final ApiClient apiClient;
  ChangePasswordApiService({required this.apiClient});

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await ApiClient.headerSet(null);
      final body = {
        'old_password': currentPassword,
        'new_password': newPassword,
      };

      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.changePassword,
        body: body,
      );

      if (response['success'] == true) {
        return true;
      }

      final message = response is Map ? response['message'] : null;
      if (message is String && message.isNotEmpty) {
        throw Exception(message);
      }
      throw Exception('Failed to change password');
    } on DioException catch (e) {
      throw Exception(ErrorHandle.handleDioError(e));
    } catch (error) {
      throw Exception(ErrorHandle.formatErrorMessage(error));
    }
  }
}
