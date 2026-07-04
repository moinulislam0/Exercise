import 'package:flutter/material.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/data/models/suggested_model.dart';

class SuggestedApiService {
  final ApiClient apiClient;

  SuggestedModel? getData;

  SuggestedApiService({required this.apiClient, this.getData});

  Future<SuggestedModel> suggested() async {
    try {
      await ApiClient.headerSet(null);
      final response = await apiClient.getRequest(endpoints: ApiEndpoints.suggestedVideo);

      if (response != null && response['success'] == true) {
        getData = SuggestedModel.fromJson(response);
        return getData!;
      }

      throw Exception(response?['message'] ?? 'Failed to load suggested data');
    } catch (e) {
      debugPrint("Error in SuggestedApiService: $e");
      rethrow;
    }
  }
}
