import 'package:touralie33_fo222668a7688/data/models/membership_model.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/membership_api_service.dart';

class MemberShipRepository {
  MembershipApiService resource;
  MemberShipRepository({required this.resource});
  Future<MembershipModel>membership()async{
    return await resource.membership();
  }
}