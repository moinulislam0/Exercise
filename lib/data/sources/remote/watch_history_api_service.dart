import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/data/models/watch_history_model.dart';

class WatchHistoryApiService {
  ApiClient apiClient;
  WatchHistoryModel watchHistoryModel;
  WatchHistoryApiService({required this.apiClient,required this.watchHistoryModel});
  Future<WatchHistoryModel>watchhistory()async{
    try{
     final response = await apiClient.getRequest(endpoints: ApiEndpoints.watchHistory);
     if(response != null && response['success']==true){
       watchHistoryModel = WatchHistoryModel.fromJson(response);
       return watchHistoryModel;
     }
 throw Exception(response?['message'] ?? 'Failed to load prescription data');
    }
    catch(e){
      rethrow;
    }
  }
}