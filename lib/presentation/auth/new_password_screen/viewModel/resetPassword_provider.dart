import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/repositories/resetPassword_reposityory.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/reset_password_api_service.dart';

class ResetState {
  final String? errorMessage;
  final bool isLoading;
  ResetState({this.errorMessage, required this.isLoading});

  ResetState copyWith({bool? isLoading, String? errorMessage}) {
    return ResetState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ResetPasswordProvider extends StateNotifier<ResetState> {
  final ResetpasswordReposityory repository;
  ResetPasswordProvider({required this.repository})
      : super(ResetState(isLoading: false));

  Future<bool> resetPass({
    required String email,
    required String token,
    required String pass,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response =
          await repository.resetPassword(email: email, pass: pass, token: token);
      state = state.copyWith(isLoading: false, errorMessage: null);
      return response;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: ErrorHandle.formatErrorMessage(e),
      );
      return false;
    }
  }
}

final resetPasswordProvider =
    StateNotifierProvider<ResetPasswordProvider, ResetState>((ref) {
  return ResetPasswordProvider(
    repository: ResetpasswordReposityory(
      resource: ResetPasswordApiService(apiClient: ApiClient()),
    ),
  );
});
