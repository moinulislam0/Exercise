import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/models/get_me_model.dart';
import 'package:touralie33_fo222668a7688/data/repositories/getMe_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/get_me_api_service.dart';

class GetState {
  final bool isLoading;
  final String? errorMessage;
  final GetMeModel? me;

  GetState({required this.isLoading, this.errorMessage, this.me});

  GetState copyWith({bool? isLoading, String? errorMessage, GetMeModel? me}) {
    return GetState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      me: me ?? this.me,
    );
  }
}


class GetMeProvider extends StateNotifier<GetState> {
  final GetmeRepository repository;

  GetMeProvider({required this.repository}) : super(GetState(isLoading: false));

  Future<bool> getMe() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final me = await repository.getmeData();
      if (me == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load user data',
        );
        return false;
      }

      final ok = me.success == true;
      state = state.copyWith(
        isLoading: false,
        me: me,
        errorMessage: ok ? null : (me.message ?? 'Failed to load user data'),
      );
      return ok;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: ErrorHandle.formatErrorMessage(e),
      );
      return false;
    }
  }
}

final getMeProvider = StateNotifierProvider<GetMeProvider, GetState>((ref) {
  return GetMeProvider(
    repository: GetmeRepository(
      resource: GetMeApiService(apiClient: ApiClient()),
    ),
  );
});
