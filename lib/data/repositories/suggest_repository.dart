import 'package:touralie33_fo222668a7688/data/sources/remote/suggested_api_service.dart';
import 'package:touralie33_fo222668a7688/data/models/suggested_model.dart';

class SuggestRepository {
  SuggestedApiService resource;
  SuggestRepository({required this.resource});
  Future<SuggestedModel> suggested() async {
    return await resource.suggested();
  }
}
