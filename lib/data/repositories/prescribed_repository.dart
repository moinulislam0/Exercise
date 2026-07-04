import 'package:touralie33_fo222668a7688/data/models/prescribed_model.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/prescirbed_api_service.dart';

class PrescribedRepository {
  PrescirbedApiService resource;
  PrescribedRepository({required this.resource});
  Future<PriscirbedModel>prescribed()async{
    return await resource.prescribe();
  }
}