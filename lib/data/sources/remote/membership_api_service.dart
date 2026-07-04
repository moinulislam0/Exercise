import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/data/models/membership_model.dart';

class MembershipApiService {
  ApiClient apiClient;
  MembershipModel? membershipModel;
  MembershipApiService({required this.apiClient,this.membershipModel});
  Future<MembershipModel>membership()async{
    try{
      final response = await apiClient.getRequest(endpoints: ApiEndpoints.membership);
      if(response != null && response["success"]==true){
        membershipModel= MembershipModel.fromJson(response);
        return membershipModel!;
      }
     throw Exception(response?['message'] ?? 'Failed to load prescription data');
    }
    catch(e){
     rethrow;
    }
  }
  
}
