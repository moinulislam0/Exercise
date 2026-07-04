import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/data/models/prescription_details_model.dart';
import 'package:touralie33_fo222668a7688/data/repositories/prescription_details_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/prescription_details_service.dart';

class OnlyDetailsState {
  final bool isloading;
  final String? errorMessage;
  final PrescriptionDetialsModel? getData;

  static const _noErrorMessage = Object();
  static const _noData = Object();

  OnlyDetailsState({
    this.errorMessage,
    required this.isloading,
    this.getData,
  });

  OnlyDetailsState copyWith({
    bool? isloading,
    Object? errormessage = _noErrorMessage,
    Object? getData = _noData,
  }) {
    return OnlyDetailsState(
      errorMessage: identical(errormessage, _noErrorMessage)
          ? this.errorMessage
          : errormessage as String?,
      isloading: isloading ?? this.isloading,
      getData:
          identical(getData, _noData) ? this.getData : getData as PrescriptionDetialsModel?,
    );
  }
}

class OnlyDetailsNotifier extends StateNotifier<OnlyDetailsState> {
  final PrescriptionDetailsRepository repository;

  OnlyDetailsNotifier({required this.repository})
      : super(OnlyDetailsState(isloading: false));

  Future<void> fetchPrescriptionDetails({required String id}) async {
    state = state.copyWith(isloading: true, errormessage: null);

    try {
      final result = await repository.getData(id: id);

      state = state.copyWith(
        isloading: false,
        getData: result,
        errormessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isloading: false,
        errormessage: e.toString(),
      );
    }
  }
}

final onlyDetailsProvider = StateNotifierProvider<OnlyDetailsNotifier, OnlyDetailsState>((ref) {
  return OnlyDetailsNotifier(
    repository: PrescriptionDetailsRepository(
      resource: PrescriptionDetailsService(apiClient: ApiClient()),
    ),
  );
});
