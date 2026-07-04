import 'package:touralie33_fo222668a7688/data/models/favourite_model.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/favourite_api_service.dart';

class FavouriteRepository {
  FavouriteApiService resource;

  FavouriteRepository({required this.resource});
  
  Future<FavouriteModel>favourite({Filter? filter})async{
    return await resource.favourite(filter: filter);
  }
  }
