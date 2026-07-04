import 'package:touralie33_fo222668a7688/data/models/prescription_resume_model.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/prescription_resume_api_service.dart';

class PrescriptioResumeRepository {
  PrescriptionResumeApiService resource;
  PrescriptionResumeModel ?getmodel;
  PrescriptioResumeRepository({required this.resource, this.getmodel});
  Future<PrescriptionResumeModel>getPrescriptionResume()async{
    return await resource.prescriptionResume();
  }
}