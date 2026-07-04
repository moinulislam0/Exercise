import 'package:touralie33_fo222668a7688/data/models/prescribed_detail_model.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/prescribed_detial_api_service.dart';

class PrescribedDetailsRepository {
  PrescirbedDetailsApiService resource;
  PrescribedDetailsRepository({required this.resource});
  Future<PriscirbedDetailsModel>prescribedDetails({required String id})async{
    return await resource.prescribeDetials(id: id);
  }
}
