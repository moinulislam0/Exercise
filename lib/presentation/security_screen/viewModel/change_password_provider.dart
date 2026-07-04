import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/repositories/change_password_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/change_password_api_service.dart';

class ChangePasswordState {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  ChangePasswordState({
    required this.isLoading,
    this.errorMessage,
    this.successMessage,
  });

  ChangePasswordState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return ChangePasswordState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

class ChangePasswordProvider extends StateNotifier<ChangePasswordState> {
  final ChangePasswordRepository repository;

  ChangePasswordProvider({required this.repository})
      : super(ChangePasswordState(isLoading: false));

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null, successMessage: null);
    try {
      final success = await repository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      state = state.copyWith(
        isLoading: false,
        successMessage: success ? 'Password changed successfully' : null,
      );
      return success;
    } catch (error) {
      final message = ErrorHandle.formatErrorMessage(error);
      state = state.copyWith(
        isLoading: false,
        errorMessage: message,
      );
      return false;
    }
  }
}

final changePasswordProvider =
    StateNotifierProvider<ChangePasswordProvider, ChangePasswordState>(
  (ref) {
    return ChangePasswordProvider(
      repository: ChangePasswordRepository(
        resource: ChangePasswordApiService(apiClient: ApiClient()),
      ),
    );
  },
);/////
