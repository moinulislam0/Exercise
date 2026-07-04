import 'package:touralie33_fo222668a7688/data/sources/remote/delete_profile_api_service.dart';

class DeleteProfileRepository {
  DeleteProfileApiService resource;
  DeleteProfileRepository({required this.resource});
  Future<bool>deleteProfile()async{
    return await resource.deleteProfile();
  }
}