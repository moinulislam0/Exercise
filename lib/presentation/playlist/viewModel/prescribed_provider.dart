import 'package:riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/models/prescribed_model.dart';
import 'package:touralie33_fo222668a7688/data/repositories/prescribed_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/prescirbed_api_service.dart';


class PrescribedState {
  final bool isLoading; 
  final String? errorMessage;
  final PriscirbedModel? data; 

  PrescribedState({
    required this.isLoading,
    this.errorMessage,
    this.data,
  });


  factory PrescribedState.initial() {
    return PrescribedState(isLoading: false, errorMessage: null, data: null);
  }


  PrescribedState copyWith({
    bool? isLoading,
    String? errorMessage,
    PriscirbedModel? data,
  }) {
    return PrescribedState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}




class PrescribedProvider extends StateNotifier<PrescribedState> {
  final PrescribedRepository repository;
  PrescribedProvider({required this.repository}) : super(PrescribedState.initial());
  Future<void> fetchPrescribed() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await repository.prescribed();
      state = state.copyWith(
        isLoading: false,
        data: response,
      );
    } catch (e) {
    
      state = state.copyWith(
        isLoading: false, 
        errorMessage: ErrorHandle.formatErrorMessage(e),
      );
    }
  }
}
final prescribedProvider= StateNotifierProvider<PrescribedProvider,PrescribedState>((ref){
  return PrescribedProvider(repository: PrescribedRepository(resource: PrescirbedApiService(apiClient: ApiClient(), priscirbedModel: PriscirbedModel())));
});
