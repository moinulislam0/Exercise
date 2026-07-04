import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/models/favourite_model.dart';
import 'package:touralie33_fo222668a7688/data/repositories/favourite_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/favourite_api_service.dart';

class FavouriteState {
  final bool isloading;
  final String ?errormessage;
  final FavouriteModel? getData;
  final Filter? selectedFilter;

  FavouriteState({
    required this.isloading,
    this.errormessage,
    this.getData,
    this.selectedFilter,
  });

  FavouriteState copyWith({
    bool? isloading,
    String? errormessage,
    FavouriteModel? getData,
    Filter? selectedFilter,
  }){
    return FavouriteState(
      isloading: isloading ?? this.isloading,
      getData: getData ?? this.getData,
      errormessage: errormessage ?? this.errormessage,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}

class FavouriteProvider extends StateNotifier<FavouriteState>{
  FavouriteRepository resource;
  FavouriteProvider({required this.resource}):super(FavouriteState(isloading: false));

  Future<void>getFavourite({Filter? filter})async{
    final appliedFilter = filter ?? state.selectedFilter;
    state = state.copyWith(isloading: true, errormessage: null);
    try{
      final response = await resource.favourite(filter: appliedFilter);
      state = state.copyWith(
        isloading: false,
        getData: response,
        errormessage: null,
        selectedFilter: appliedFilter,
      );
    }
    catch(e){
      state = state.copyWith(
        isloading: false, 
        errormessage: ErrorHandle.formatErrorMessage(e),
      );
    }
  }

  Future<void>applyCategoryFilter(String? categoryId) async {
    final filter = Filter(
      categoryId: categoryId,
      startDate: null,
      endDate: null,
    );
    await getFavourite(filter: filter);
  }
}

final favouriteProvider =StateNotifierProvider<FavouriteProvider,FavouriteState>((ref){
  return  FavouriteProvider(resource: FavouriteRepository(resource: FavouriteApiService(apiClient: ApiClient(), favouriteModel: FavouriteModel())));
});
