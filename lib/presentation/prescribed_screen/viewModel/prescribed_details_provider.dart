import 'package:riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/models/prescribed_detail_model.dart';
import 'package:touralie33_fo222668a7688/data/repositories/prescribed_details_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/prescribed_detial_api_service.dart';

class PrescribedDetailsState {
  final bool isLoading;
  final String? errorMessage;
  final PriscirbedDetailsModel? prescribedDetailsData;

  static const _noErrorMessage = Object();
  static const _noSuggestedData = Object();

  PrescribedDetailsState({
    this.errorMessage,
    required this.isLoading,
    this.prescribedDetailsData,
  });

  PrescribedDetailsState copyWith({
    bool? isLoading,
    Object? errorMessage = _noErrorMessage,
    Object? prescribedDetailsData = _noSuggestedData,
  }) {
    return PrescribedDetailsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: identical(errorMessage, _noErrorMessage)
          ? this.errorMessage
          : errorMessage as String?,
      prescribedDetailsData: identical(prescribedDetailsData, _noSuggestedData)
          ? this.prescribedDetailsData
          : prescribedDetailsData as PriscirbedDetailsModel?,
    );
  }
}

class PrescribedDetailsProvider extends StateNotifier<PrescribedDetailsState> {
  final PrescribedDetailsRepository repository;

  PrescribedDetailsProvider({required this.repository})
      : super(PrescribedDetailsState(isLoading: false));

  Future<void> getPresCribedDetails({required String id}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await repository.prescribedDetails(id: id);

      state = state.copyWith(
        isLoading: false,
        prescribedDetailsData: response,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: ErrorHandle.formatErrorMessage(e),
      );
    }
  }
}

final prescribedDetailsNotifierProvider =
    StateNotifierProvider<PrescribedDetailsProvider, PrescribedDetailsState>((ref) {
  final repository = PrescribedDetailsRepository(
    resource: PrescirbedDetailsApiService(
      apiClient: ApiClient(),
      priscirbedDetialsModel: PriscirbedDetailsModel(),
    ),
  );
  return PrescribedDetailsProvider(repository: repository);
});
