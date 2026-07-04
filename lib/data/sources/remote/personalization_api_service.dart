import 'package:dio/dio.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';

class PersonalizationApiService {
  ApiClient apiClient;
 
  PersonalizationApiService({required this.apiClient});

  Future<Map<String, dynamic>> personalization() async {
    final response = await apiClient.getRequest(endpoints: ApiEndpoints.library);
    if (response is Map<String, dynamic>) {
      return response;
    }
    if (response is Map) {
      return Map<String, dynamic>.from(response);
    }
    throw DioException(
      requestOptions: RequestOptions(path: ApiEndpoints.library),
      error: 'Unexpected response type: ${response.runtimeType}',
      type: DioExceptionType.unknown,
    );
  }
}
