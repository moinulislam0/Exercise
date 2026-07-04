import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';

class DeleteProfileApiService {
  ApiClient apiClient;
  DeleteProfileApiService({required this.apiClient});
  Future<bool>deleteProfile()async{
    try{
      final response = await apiClient.deleteRequest(endpoints: ApiEndpoints.deleteProfile);
      if(response !=null && response['success']==true){
        return true;
      }
      throw Exception(response?['message'] ?? 'Failed to Delete Profile');
    }
    catch(e){
      rethrow;
    }
  }
}