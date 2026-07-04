import 'package:riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/models/favourite_model.dart' as favourite_model;
import 'package:touralie33_fo222668a7688/data/models/suggested_model.dart';
import 'package:touralie33_fo222668a7688/data/repositories/suggest_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/suggested_api_service.dart';

class SuggestedState {
  final bool isLoading;
  final String? errorMessage;
  final SuggestedModel? suggestedData;

  static const _noErrorMessage = Object();
  static const _noSuggestedData = Object();

  SuggestedState({
    this.errorMessage,
    required this.isLoading,
    this.suggestedData,
  });

  SuggestedState copyWith({
    bool? isLoading,
    Object? errorMessage = _noErrorMessage,
    Object? suggestedData = _noSuggestedData,
  }) {
    return SuggestedState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: identical(errorMessage, _noErrorMessage)
          ? this.errorMessage
          : errorMessage as String?,
      suggestedData: identical(suggestedData, _noSuggestedData)
          ? this.suggestedData
          : suggestedData as SuggestedModel?,
    );
  }
}

class SuggestedProvider extends StateNotifier<SuggestedState> {
  final SuggestRepository repository;

  SuggestedProvider({required this.repository})
      : super(SuggestedState(isLoading: false));

  Future<void> getSuggested() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await repository.suggested();

      state = state.copyWith(
        isLoading: false,
        suggestedData: response,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: ErrorHandle.formatErrorMessage(e),
      );
    }
  }

  void removeSuggestedById(String id) {
    final currentModel = state.suggestedData;
    final currentList = currentModel?.data;

    if (currentModel == null || currentList == null) {
      return;
    }

    final updatedList = currentList.where((item) => item.id != id).toList();
    final updatedModel = SuggestedModel(
      success: currentModel.success,
      message: currentModel.message,
      data: updatedList,
      metaData: currentModel.metaData,
    );

    state = state.copyWith(suggestedData: updatedModel);
  }

  void markSuggestedAsFavourite(String id) {
    final currentModel = state.suggestedData;
    final currentList = currentModel?.data;

    if (currentModel == null || currentList == null) {
      return;
    }

    final updatedList = currentList.map((item) {
      if (item.id != id) {
        return item;
      }

      return Data(
        id: item.id,
        title: item.title,
        thumbnailUrl: item.thumbnailUrl,
        category: item.category,
        chaptersCount: item.chaptersCount,
        createdAt: item.createdAt,
        duration: item.duration,
        level: item.level,
        isFavorite: true,
      );
    }).toList();

    final updatedModel = SuggestedModel(
      success: currentModel.success,
      message: currentModel.message,
      data: updatedList,
      metaData: currentModel.metaData,
    );

    state = state.copyWith(suggestedData: updatedModel);
  }

  void addSuggestedFromFavourite(favourite_model.Data item) {
    final currentModel = state.suggestedData;
    final currentList = currentModel?.data ?? <Data>[];

    if (item.id == null || item.id!.isEmpty) {
      return;
    }

    final alreadyExists = currentList.any((video) => video.id == item.id);
    if (alreadyExists) {
      return;
    }

    final updatedList = [
      Data(
        id: item.id,
        title: item.title,
        thumbnailUrl: item.thumbnailUrl,
        category: item.category,
        chaptersCount: item.chaptersCount,
        createdAt: item.createdAt,
        duration: item.duration,
        level: item.level,
        isFavorite: false,
      ),
      ...currentList,
    ];

    final updatedModel = SuggestedModel(
      success: currentModel?.success ?? true,
      message: currentModel?.message,
      data: updatedList,
      metaData: currentModel?.metaData,
    );

    state = state.copyWith(suggestedData: updatedModel);
  }
}
final suggestedNotifierProvider = StateNotifierProvider<SuggestedProvider, SuggestedState>((ref) {
  final repository = SuggestRepository(
    resource: SuggestedApiService(apiClient: ApiClient())
  );
  return SuggestedProvider(repository: repository);
});
