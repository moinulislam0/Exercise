import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/repositories/verify_otp_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/verify_email_servicce.dart';

class OtpState {
  final bool isLoading;
  final String? errorMessage;
  final String? resetToken;

  OtpState({required this.isLoading, this.errorMessage, this.resetToken});

  OtpState copyWith({bool? isLoading, String? errorMessage, String? resetToken}) {
    return OtpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      resetToken: resetToken ?? this.resetToken,
    );
  }
}

class OtpProvider extends StateNotifier<OtpState> {
  final VerifyOtpRepository repository;

  OtpProvider({required this.repository}) : super(OtpState(isLoading: false));

Future<bool> verifyOtp({required String email, required String token}) async {
  state = state.copyWith(isLoading: true, errorMessage: null, resetToken: null);
  try {
    final response = await repository.verifyOtp(email: email, token: token);

    final success = response['success'] == true || response['status'] == 'success';
    
    if (!success) {
      final message = response['message'];
      state = state.copyWith(
        isLoading: false,
        errorMessage: message is String ? message : message?.toString(),
      );
      return false; 
    }

    final extractedResetToken =
        response['resetToken']?.toString() ??
        response['reset_token']?.toString() ??
        response['token']?.toString() ??
        response['data']?['resetToken']?.toString() ??
        response['data']?['reset_token']?.toString() ??
        response['data']?['token']?.toString() ??
        token;

    await SharedPreferenceData.setResetPasswordToken(extractedResetToken);

    state = state.copyWith(
      isLoading: false, 
      resetToken: extractedResetToken, 
    );
    return true; 

  } catch (e) {
    state = state.copyWith(
      isLoading: false,
      errorMessage: ErrorHandle.formatErrorMessage(e),
    );
    return false;
  }
}}

final otpProvider = StateNotifierProvider<OtpProvider, OtpState>((ref) {
  return OtpProvider(
    repository: VerifyOtpRepository(
      resource: VerifyEmailServicce(apiClient: ApiClient()),
    ),
  );
});
