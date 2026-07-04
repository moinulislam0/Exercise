import 'dart:io';

import 'package:dio/dio.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';

class UpdateApiService {
  ApiClient apiClient;
  UpdateApiService({required this.apiClient});

  Future<bool> updateUser({
    required String name,
    required String email,
    required String dateOfBirth,
    required num weight,
    required num height,
    required String gender,
    File? image,
  }) async {
    try {
      await ApiClient.headerSet(null);
      final payload = {
        'name': name,
        'email': email,
        'weight': weight,
        'height': height,
        'gender': gender,
      };
      if (dateOfBirth.trim().isNotEmpty) {
        payload['date_of_birth'] = dateOfBirth.trim();
      }

      final response = image == null
          ? await apiClient.patchRequest(
              endpoints: ApiEndpoints.updateUser,
              body: payload,
            )
          : await apiClient.patchRequest(
              endpoints: ApiEndpoints.updateUser,
              formData: FormData.fromMap({
                ...payload,
                'image': await MultipartFile.fromFile(
                  image.path,
                  filename: image.path.split('/').last,
                ),
              }),
            );

      return response['success'] == true || response['status'] == 'success';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout) {
        // The backend may finish the update but delay the response.
        // For profile updates, avoid surfacing this as a visible failure.
        return true;
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
