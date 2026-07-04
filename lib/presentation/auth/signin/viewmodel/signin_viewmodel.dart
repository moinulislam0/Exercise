import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/repositories/auth_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/auth_api_service.dart';


class SignInState {
  final bool isLoading;
  final String? errorMessage; 

  SignInState({required this.isLoading, this.errorMessage});

  SignInState copyWith({bool? isLoading, String? errorMessage}) {
    return SignInState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}


class SignInViewModel extends StateNotifier<SignInState> {
  final AuthRepository repository;

  SignInViewModel({required this.repository}) : super(SignInState(isLoading: false));

  Future<bool> signIn({
    required String email,
    required String password,
    String? fcmToken,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await repository.login(
        email: email,
        password: password,
        fcmToken: fcmToken,
      );
      state = state.copyWith(isLoading: false); 
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: ErrorHandle.formatErrorMessage(e),
      );
      return false;
    }
  }
}


final signInViewModelProvider = StateNotifierProvider<SignInViewModel, SignInState>((ref) {
  return SignInViewModel(
    repository: AuthRepository(
      remoteSource: AuthApiService(apiClient: ApiClient()),
    ),
  );
});

final eyeSecure = StateProvider<bool>((ref) => true); 
final checkIcon = StateProvider<bool>((ref) => false); 
