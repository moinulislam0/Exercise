import 'package:riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/repositories/delete_profile_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/delete_profile_api_service.dart';

class DeleteState {
  final bool isloading;
  final String? errormessage;

 DeleteState ({required this.isloading, this.errormessage});

  DeleteState copyWith({bool? isloading, String? errormessage}) {
    return DeleteState (
      isloading: isloading ?? this.isloading,
      errormessage: errormessage ?? this.errormessage,
    );
  }
}

class DeleteProvider extends StateNotifier<DeleteState > {
  final DeleteProfileRepository repository;

  DeleteProvider({required this.repository})
      : super(DeleteState(isloading: false));

  Future<bool> deleteProfile() async {
    state = state.copyWith(isloading: true, errormessage: null);
    try {
      final success = await repository.deleteProfile();
      state = state.copyWith(
        isloading: false,
        errormessage: success ? null : 'Failed to update user',
      );
      return success;
    } catch (e) {
      final message = ErrorHandle.formatErrorMessage(e);
      state = state.copyWith(isloading: false, errormessage: message);
      return false;
    }
  }
}

final deleteProvider = StateNotifierProvider<DeleteProvider, DeleteState>((
  ref,
) {
  return DeleteProvider(
    repository:DeleteProfileRepository(
      resource: DeleteProfileApiService(apiClient: ApiClient()),
    ),
  );
});
