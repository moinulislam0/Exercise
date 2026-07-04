import 'dart:developer';
import '../../../core/network/api_clients.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/service/notification_service.dart';
import '../../../core/network/error_handle.dart';
import 'package:dio/dio.dart';
import '../local/shared_preference/shared_preference.dart';

class AuthApiService {
  final ApiClient apiClient;
  AuthApiService({required this.apiClient});
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String weight,
    required String height,
    required String gender,
    required String dateOfBirth,
    required String personalization,
    required String type,
  }) async {
    try {
      final trimmedWeight = weight.trim();
      final trimmedHeight = height.trim();
      final weightNum = trimmedWeight.isEmpty
          ? null
          : num.tryParse(trimmedWeight);
      final heightNum = trimmedHeight.isEmpty
          ? null
          : num.tryParse(trimmedHeight);
      if (trimmedWeight.isNotEmpty && weightNum == null) {
        throw Exception('Invalid weight');
      }
      if (trimmedHeight.isNotEmpty && heightNum == null) {
        throw Exception('Invalid height');
      }

      final personalizationList = personalization
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final Map<String, dynamic> body = {
        'email': email,
        'name': name,
        'password': password,
        'type': type,
      };
      if (weightNum != null) {
        body['weight'] = weightNum;
      }
      if (heightNum != null) {
        body['height'] = heightNum;
      }
      if (gender.trim().isNotEmpty) {
        body['gender'] = gender.trim();
      }
      if (dateOfBirth.trim().isNotEmpty) {
        body['date_of_birth'] = dateOfBirth.trim();
      }
      if (personalizationList.isNotEmpty) {
        body['personalization'] = personalizationList;
      }
      final dynamic response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.register,
      );
      if (response == null) {
        throw Exception('Registration failed: empty response');
      }
      if (response is! Map) {
        throw Exception(
          'Registration failed: unexpected response type ${response.runtimeType}',
        );
      }

      final map = Map<String, dynamic>.from(response);
      log('Register response: $map');

      final success = map['success'] == true;
      if (success) {
        final token = map['authorization']?['access_token'];
        if (token is String && token.isNotEmpty) {
          await SharedPreferenceData.setToken(token);
        }
        return true;
      }

      final message = map['message'];
      if (message is String && message.isNotEmpty) {
        throw Exception(message);
      }
      throw Exception('Registration failed');
    } on DioException catch (e) {
      final message = ErrorHandle.handleDioError(e);
      throw Exception(message);
    }
  }

  Future<bool> login({
    required String email,
    required String password,
    String? fcmToken,
  }) async {
    try {
      final body = {
        "email": email,
        "password": password,
        "fcm_token": fcmToken ?? '',
      };
      final dynamic response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.login,
      );
      if (response['success'] == true) {
        await SharedPreferenceData.setToken(
          response['authorization']['access_token'],
        );
        await NotificationService.syncTokenAfterLogin();
        final token = await SharedPreferenceData.getToken();
        log("$token");
        return true;
      } else {
        final message = response is Map ? response['message'] : null;
        if (message is String && message.isNotEmpty) {
          throw Exception(message);
        }
        return false;
      }
    } on DioException catch (e) {
      throw Exception(ErrorHandle.handleDioError(e));
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> forgotPass({required String email}) async {
    try {
      final body = {"email": email};
      final dynamic response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.forgotPass,
      );
      if (response['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> logout() async {
    try {
      await ApiClient.headerSet(null);
      final dynamic response = await apiClient.postRequest(
        body: const {},
        endpoints: ApiEndpoints.logout,
      );
      if (response['success'] == true) {
        return true;
      }
      final message = response is Map ? response['message'] : null;
      if (message is String && message.isNotEmpty) {
        throw Exception(message);
      }
      return false;
    } on DioException catch (e) {
      throw Exception(ErrorHandle.handleDioError(e));
    } catch (error) {
      rethrow;
    }
  }
}
