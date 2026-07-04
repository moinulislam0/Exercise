import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';

class MembershipIdApiService {
  ApiClient apiClient;
  MembershipIdApiService({required this.apiClient});

  Future<bool>membershipid({required String id,required String name,required String email,required String phone,required String message})async{
    try{
      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.memberShipId(id),
        body: {
          'name': name,
          'email': email,
          'phone': phone,
          'message': message,
        },
      );
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
