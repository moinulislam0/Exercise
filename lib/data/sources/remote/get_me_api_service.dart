import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/data/models/get_me_model.dart';
import 'dart:developer'; 

class GetMeApiService {
  final ApiClient apiClient;
  GetMeModel? getData;

  GetMeApiService({required this.apiClient, this.getData});

  Future<GetMeModel?> getme() async {
    try {
      await ApiClient.headerSet(null);
     
      final response = await apiClient.getRequest(endpoints: ApiEndpoints.getMe);

      if (response is Map) {
        getData = GetMeModel.fromJson(Map<String, dynamic>.from(response));
        log("GetMe data fetched successfully");
        return getData;
      }
      log("GetMe failed: unexpected response type ${response.runtimeType}");
      return null;
    } catch (e) {
      log("Error in GetMeApiService: $e");
      return null;
    }
  }
}
