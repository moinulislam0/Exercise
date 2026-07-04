import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/data/models/prescription_resume_model.dart';

class PrescriptionResumeApiService {
  ApiClient apiClient;
  PrescriptionResumeModel? getPrescription;
  PrescriptionResumeApiService({required this.apiClient, this.getPrescription});

  Future<PrescriptionResumeModel> prescriptionResume() async {
    try {
      await ApiClient.headerSet(null);
      final response = await apiClient.getRequest(endpoints: ApiEndpoints.prescriptionResume);

      if (response != null && response['success'] == true) {
        getPrescription = PrescriptionResumeModel.fromJson(response);
        return getPrescription!;
      }

      throw Exception(response?['message'] ?? 'Failed to load prescription data');
    } catch (e) {
      rethrow;
    }
  }
}
