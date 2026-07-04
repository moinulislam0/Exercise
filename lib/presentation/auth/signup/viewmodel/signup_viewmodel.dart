import 'dart:developer';
import 'package:riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/repositories/auth_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/auth_api_service.dart';



class SignUpState {
  final bool isLoading;
  final String? errorMessage; 

  SignUpState({required this.isLoading, this.errorMessage});

  SignUpState copyWith({bool? isLoading, String? errorMessage}) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class SignupViewmodel extends StateNotifier<SignUpState>{
  AuthRepository repository;
  SignupViewmodel ({required this.repository}) : super(SignUpState(isLoading: false));

  Future<bool> signup({
    required String name,
    required String email,
    required String password,
    String type = 'user',
  }) async {
    state =state.copyWith(isLoading: true,errorMessage: null);
    try {
      final weight = (await SharedPreferenceData.getOnboardingWeight())?.trim();
      final height = (await SharedPreferenceData.getOnboardingHeight())?.trim();
      final gender = (await SharedPreferenceData.getOnboardingGender())?.trim();
      final dateOfBirth =
          (await SharedPreferenceData.getOnboardingDateOfBirth())?.trim();
      final personalization =
          (await SharedPreferenceData.getOnboardingPersonalizationCsv()).trim();

      final success = await repository.register(
        name: name,
        email: email,
        password: password,
        weight: weight ?? '',
        height: height ?? '',
        gender: gender ?? '',
        dateOfBirth: dateOfBirth ?? '',
        personalization: personalization,
        type: "user",
      );
      state = state.copyWith(isLoading: false); 
      return success;
    } catch (e, st) {
      log('Signup failed: $e', stackTrace: st);
      state = state.copyWith(
        isLoading: false,
        errorMessage: ErrorHandle.formatErrorMessage(e),
      );
      return false;
    }
  }

}

final signUpViewModelProvider =
    StateNotifierProvider<SignupViewmodel, SignUpState>((ref) {
  return SignupViewmodel(
    repository: AuthRepository(
      remoteSource: AuthApiService(apiClient: ApiClient()),
    ),
  );
});
