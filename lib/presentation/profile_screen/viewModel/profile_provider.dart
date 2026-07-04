import 'package:riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/models/watch_history_model.dart';
import 'package:touralie33_fo222668a7688/data/repositories/watch_history_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/watch_history_api_service.dart';

class ProfileState{
  final bool isloading;
  final String ?errormessage;
  final WatchHistoryModel ?getData;
  ProfileState({required this.isloading,this.errormessage,this.getData});
  ProfileState copyWith({bool ? isloading,String ? errormessage,WatchHistoryModel ? getData}){
    return ProfileState(isloading: isloading ?? this.isloading,errormessage: errormessage ?? this.errormessage,getData: getData?? this.getData);
  }
}

class ProfileProvider extends StateNotifier<ProfileState>{
  WatchHistoryRepository resource;
  ProfileProvider({required this.resource}):super(ProfileState(isloading:  false));
  Future<bool> profileData()async{
    state = state.copyWith(isloading: true, errormessage: null);
    try{
      final response = await resource.watchHistory();
      state = state.copyWith(
        isloading: false,
        getData: response,
        errormessage: null,
      );
      return true;

    }
    catch(e){
      state = state.copyWith(
        isloading: false,
        errormessage: ErrorHandle.formatErrorMessage(e),
      );
      return false;
    }
  }
}


final profileProvider= StateNotifierProvider<ProfileProvider,ProfileState>((ref){
 return ProfileProvider(resource: WatchHistoryRepository(resource: WatchHistoryApiService(apiClient: ApiClient(), watchHistoryModel: WatchHistoryModel())));
});
