import 'package:riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/repositories/favourite_id_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/favourite_id_api_service.dart';

class FavouriteIdState {
  final bool isloading;
  final String? errormessage;
  FavouriteIdState({required this.isloading,this.errormessage});
  FavouriteIdState copyWith({bool? isloading,String? errormessage}){
    return FavouriteIdState(isloading: isloading?? this.isloading,errormessage: errormessage?? this.errormessage);
  }
}

class FavouriteIdProvider extends StateNotifier<FavouriteIdState>{
  FavouriteIdRepository resource;
  FavouriteIdProvider({required this.resource}):super(FavouriteIdState(isloading: false));
  Future<bool>favouriteId({required String id})async{
    state = state.copyWith(isloading: true, errormessage: null);
    try{
      final response = await resource.favourite(id: id);
      state = state.copyWith(isloading: false, errormessage: null);
      return response;
    }
    catch(e){
      state = state.copyWith(
        isloading: false,
        errormessage: ErrorHandle.formatErrorMessage(e),
      );
      rethrow;
    }
  }
}
final favouriteIdProvider= StateNotifierProvider<FavouriteIdProvider,FavouriteIdState>((ref){
  return FavouriteIdProvider(resource: FavouriteIdRepository(resource: FavouriteIdApiService(apiClient: ApiClient())));
});
