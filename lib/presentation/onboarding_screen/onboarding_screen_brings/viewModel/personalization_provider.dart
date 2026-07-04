import 'dart:developer';
import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/models/personalization_model.dart';
import 'package:touralie33_fo222668a7688/data/repositories/personalization_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/personalization_api_service.dart';
import '../../../../core/network/api_clients.dart'; 


class PersonalizationState {
  final bool isLoading;
  final String? errorMessage;

  PersonalizationState({required this.isLoading, this.errorMessage});

  PersonalizationState copyWith({bool? isLoading, String? errorMessage}) {
    return PersonalizationState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// --- Provider Class ---
class PersonalizationViewModel extends StateNotifier<PersonalizationState> {
  final PersonalizationRepository repository;
  

  PersonalizationModel? _personalizationData;
  PersonalizationModel? get personalizationData => _personalizationData;

  PersonalizationViewModel({required this.repository}) 
      : super(PersonalizationState(isLoading: false));

  
  Future<void> getCategories() async {
   
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
   
      final response = await repository.personalization();
   
      _personalizationData = PersonalizationModel.fromJson(response);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      log("Error fetching categories: $e");

      state = state.copyWith(
        isLoading: false,
        errorMessage: ErrorHandle.formatErrorMessage(e),
      );
    }
  }
}

// --- Global Provider ---
final personalizationProvider =
    StateNotifierProvider<PersonalizationViewModel, PersonalizationState>((ref) {
  return PersonalizationViewModel(
    repository: PersonalizationRepository(
      remoteSource: PersonalizationApiService(apiClient: ApiClient()), 
    ),
  );
});
