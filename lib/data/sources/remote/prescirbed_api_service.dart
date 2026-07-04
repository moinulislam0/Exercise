import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/data/models/prescribed_model.dart';

class PrescirbedApiService {
  ApiClient apiClient;
  PriscirbedModel priscirbedModel;
  PrescirbedApiService({required this.apiClient, required this.priscirbedModel});
  Future<PriscirbedModel>prescribe()async{
    try{
      final response = await apiClient.getRequest(endpoints: ApiEndpoints.prescribe);
     if (response != null && response['success'] == true){
      priscirbedModel = PriscirbedModel.fromJson(response);

      return  priscirbedModel;
     }
      throw Exception(response?['message'] ?? 'Failed to load prescription data');
    }
    catch(e){
      rethrow;
    }
  }
 }