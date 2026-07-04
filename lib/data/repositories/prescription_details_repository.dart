import 'package:touralie33_fo222668a7688/data/models/prescription_details_model.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/prescription_details_service.dart';

class PrescriptionDetailsRepository {
  PrescriptionDetailsService resource;
  PrescriptionDetailsRepository({required this.resource});
  Future<PrescriptionDetialsModel>getData({required String id})async{
    return await resource.getData(id: id);
  }
}