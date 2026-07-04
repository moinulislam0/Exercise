import 'package:touralie33_fo222668a7688/data/models/watch_history_model.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/watch_history_api_service.dart';

class WatchHistoryRepository {
  WatchHistoryApiService resource;
  WatchHistoryRepository({required this.resource});
  Future<WatchHistoryModel>watchHistory()async{
    return await resource.watchhistory();
  }
}