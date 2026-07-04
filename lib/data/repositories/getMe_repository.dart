import 'package:touralie33_fo222668a7688/data/sources/remote/get_me_api_service.dart';
import 'package:touralie33_fo222668a7688/data/models/get_me_model.dart';

class GetmeRepository {
  GetMeApiService resource;
  GetmeRepository({required this.resource});

  Future<GetMeModel?> getmeData() async {
    return resource.getme();
  }
}
