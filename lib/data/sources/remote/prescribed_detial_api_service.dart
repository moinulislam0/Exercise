import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/data/models/prescribed_detail_model.dart';

class PrescirbedDetailsApiService {
  ApiClient apiClient;
  PriscirbedDetailsModel priscirbedDetialsModel;
  PrescirbedDetailsApiService ({required this.apiClient, required this.priscirbedDetialsModel});
  Future<PriscirbedDetailsModel>prescribeDetials({required String id})async{
    try{
      final response = await apiClient.getRequest(endpoints: ApiEndpoints.prescribedDetails(id));
     if (response != null && response['success'] == true){
      priscirbedDetialsModel = PriscirbedDetailsModel.fromJson(response);

      return  priscirbedDetialsModel;
     }
      throw Exception(response?['message'] ?? 'Failed to load prescription data');
    }
    catch(e){
      rethrow;
    }
  }
 }
