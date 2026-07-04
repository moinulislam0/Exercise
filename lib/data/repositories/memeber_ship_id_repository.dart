import 'package:touralie33_fo222668a7688/data/sources/remote/memberShip_id_api_service.dart';

class MemeberShipIdRepository {
  MembershipIdApiService resource;
  MemeberShipIdRepository({required this.resource});
  Future<bool> memberShipId({required String id,required String name,required String email,required String phone,required String message})async{
    return await resource.membershipid( id :id,  name:name, email:email, phone:phone, message:message);
  }
}