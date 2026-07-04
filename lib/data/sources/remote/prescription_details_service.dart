import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/data/models/prescription_details_model.dart';

class PrescriptionDetailsService {
  final ApiClient apiClient;

  PrescriptionDetailsService({required this.apiClient});

  Future<PrescriptionDetialsModel> getData({required String id}) async {
    try {
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.prescriptionDetails(id),
      );


      if (response != null && response['success'] == true) {
    
        return PrescriptionDetialsModel.fromJson(response);
      } else {

        throw Exception(response?['message'] ?? 'Failed to load prescription data');
      }
    } catch (e) {
      
      rethrow;
    }
  }
}