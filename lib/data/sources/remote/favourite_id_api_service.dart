import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';

class FavouriteIdApiService {
  ApiClient apiClient;
  FavouriteIdApiService({required this.apiClient});
  Future<bool> favouriteId({required String id})async{
    try{
      final response = await apiClient.patchRequest(endpoints: ApiEndpoints.favouriteId(id));
      if(response !=null && response['success']==true){
        return true;
      }
       throw Exception(response?['message'] ?? 'Failed to load prescription data');
    }
    catch(e){
      rethrow;
    }
  }
}
