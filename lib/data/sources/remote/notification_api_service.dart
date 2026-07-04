import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/data/models/notification_model.dart';

class NotificationApiService {
  ApiClient apiClient;
  NotificationModel? notificationModel;
  NotificationApiService({required this.apiClient, this.notificationModel});

  Future<NotificationModel> notification() async {
    
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.notification,
      );
      if (response != null && response['success'] == true) {
        return NotificationModel.fromJson(response);
      }
      throw Exception(response?['message'] ?? 'Failed to load notifications');
    } catch (e) {
      rethrow;
    }
  }
}
