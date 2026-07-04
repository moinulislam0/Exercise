import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/data/models/favourite_model.dart';

class FavouriteApiService {
  ApiClient apiClient;
  FavouriteModel favouriteModel;
  FavouriteApiService({required this.apiClient,required this.favouriteModel});
  Future<FavouriteModel>favourite({Filter? filter})async{
    try{
      final queryParameters = <String, dynamic>{
        if (filter?.categoryId != null) 'category_id': filter!.categoryId,
        if (filter?.startDate != null) 'start_date': filter!.startDate,
        if (filter?.endDate != null) 'end_date': filter!.endDate,
      };
      final response = await apiClient.getRequest(
        endpoints: ApiEndpoints.favourite,
        queryParameters: queryParameters.isEmpty ? null : queryParameters,
      );
      if(response !=null && response['success']==true){
        favouriteModel= FavouriteModel.fromJson(response);
        return favouriteModel;
      }
        throw Exception(response?['message'] ?? 'Failed to load prescription data');
    }

    catch(e){
      rethrow;
    }
  }
}
