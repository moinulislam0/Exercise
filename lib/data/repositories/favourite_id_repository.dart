import 'package:touralie33_fo222668a7688/data/sources/remote/favourite_id_api_service.dart';

class FavouriteIdRepository {
  FavouriteIdApiService resource;
  FavouriteIdRepository({required this.resource});
  Future<bool> favourite({required String id})async{
    return await resource.favouriteId(id: id);
  }
}