import 'package:riverpod/legacy.dart';
import 'package:dio/dio.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/models/prescription_resume_model.dart';
import 'package:touralie33_fo222668a7688/data/repositories/prescriptio_resume_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/prescription_resume_api_service.dart';

class PrescriptionResumeState {
  final bool isLoading;
  final String? errorMessage;
  final PrescriptionResumeModel? prescriptionData;

  static const _noErrorMessage = Object();
  static const _noPrescriptionData = Object();

  PrescriptionResumeState({
    required this.isLoading,
    this.errorMessage,
    this.prescriptionData,
  });

  PrescriptionResumeState copyWith({
    bool? isLoading,
    Object? errorMessage = _noErrorMessage,
    Object? prescriptionData = _noPrescriptionData,
  }) {
    return PrescriptionResumeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: identical(errorMessage, _noErrorMessage)
          ? this.errorMessage
          : errorMessage as String?,
      prescriptionData: identical(prescriptionData, _noPrescriptionData)
          ? this.prescriptionData
          : prescriptionData as PrescriptionResumeModel?,
    );
  }
}

class GetPrescriptionResumeProvider
    extends StateNotifier<PrescriptionResumeState> {
  final PrescriptioResumeRepository repository;

  GetPrescriptionResumeProvider({required this.repository})
      : super(PrescriptionResumeState(isLoading: false));

  Future<void> getPrescription() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await repository.getPrescriptionResume();

      state = state.copyWith(
        isLoading: false,
        prescriptionData: response,
        errorMessage: null,
      );
    } catch (e) {
      final message = e is DioException && e.response?.statusCode == 401
          ? 'Unauthorized request. Please sign in again.'
          : ErrorHandle.formatErrorMessage(e);
      state = state.copyWith(
        isLoading: false,
        errorMessage: message,
      );
    }
  }
}

final getPrescriptionResumeProvider = StateNotifierProvider<GetPrescriptionResumeProvider,PrescriptionResumeState>((ref){
  return GetPrescriptionResumeProvider(repository: PrescriptioResumeRepository(resource: PrescriptionResumeApiService(apiClient: ApiClient()) ));
});
