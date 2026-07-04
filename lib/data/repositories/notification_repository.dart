import 'package:touralie33_fo222668a7688/data/models/notification_model.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/notification_api_service.dart';

class NotificationRepository {
  NotificationApiService resource;
  NotificationRepository({required this.resource});
  Future<NotificationModel> notification()async{
    return await resource.notification();
  }
}