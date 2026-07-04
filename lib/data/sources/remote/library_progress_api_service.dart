import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';

class LibraryProgressApiService {
  final ApiClient apiClient;

  LibraryProgressApiService({required this.apiClient});

  Future<bool> syncProgress({
    required String id,
    required int lastWatchPositionSeconds,
    required bool isCompleted,
    String? prescriptionId,
  }) async {
    try {
      final body = <String, dynamic>{
        'last_played_position': lastWatchPositionSeconds,
        'is_completed': isCompleted,
      };
      if (prescriptionId != null && prescriptionId.trim().isNotEmpty) {
        body['prescription_id'] = prescriptionId;
      }

      final response = await apiClient.patchRequest(
        endpoints: ApiEndpoints.libraryProgress(id),
        body: body,
      );
      if (response != null && response['success'] == true) {
        return true;
      }
      throw Exception(response?['message'] ?? 'Failed to update progress');
    } catch (e) {
      rethrow;
    }
  }
}
