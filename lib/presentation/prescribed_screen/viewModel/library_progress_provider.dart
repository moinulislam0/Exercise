import 'package:flutter_riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/core/network/error_handle.dart';
import 'package:touralie33_fo222668a7688/data/repositories/library_progress_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/library_progress_api_service.dart';

class LibraryProgressState {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, int> syncedPositionById;
  final Set<String> completedIds;

  const LibraryProgressState({
    required this.isLoading,
    this.errorMessage,
    this.syncedPositionById = const <String, int>{},
    this.completedIds = const <String>{},
  });

  LibraryProgressState copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, int>? syncedPositionById,
    Set<String>? completedIds,
  }) {
    return LibraryProgressState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      syncedPositionById: syncedPositionById ?? this.syncedPositionById,
      completedIds: completedIds ?? this.completedIds,
    );
  }
}

class LibraryProgressProvider extends StateNotifier<LibraryProgressState> {
  final LibraryProgressRepository resource;
  final Map<String, int> _lastSyncedPositionById = <String, int>{};
  final Set<String> _syncingIds = <String>{};

  LibraryProgressProvider({required this.resource})
    : super(const LibraryProgressState(isLoading: false));

  Future<void> syncProgress({
    required String id,
    required int positionMilliseconds,
    bool isCompleted = false,
    bool force = false,
    String? prescriptionId,
  }) async {
    if (id.isEmpty) return;

    final safePositionMilliseconds = positionMilliseconds < 0
        ? 0
        : positionMilliseconds;
    final previousPositionMilliseconds = _lastSyncedPositionById[id] ?? -1;
    final shouldSync =
        force ||
        isCompleted ||
        previousPositionMilliseconds < 0 ||
        (safePositionMilliseconds - previousPositionMilliseconds).abs() >= 5000;

    if (!shouldSync || _syncingIds.contains(id)) {
      return;
    }

    _syncingIds.add(id);
    final normalizedPositionMilliseconds =
        safePositionMilliseconds < previousPositionMilliseconds
        ? previousPositionMilliseconds
        : safePositionMilliseconds;
    final updatedCompletedIds = <String>{
      ...state.completedIds,
      if (isCompleted) id,
    };
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      syncedPositionById: <String, int>{
        ...state.syncedPositionById,
        id: normalizedPositionMilliseconds,
      },
      completedIds: updatedCompletedIds,
    );

    try {
      await resource.syncProgress(
        id: id,
        lastWatchPositionSeconds: (normalizedPositionMilliseconds / 1000)
            .floor(),
        isCompleted: isCompleted,
        prescriptionId: prescriptionId,
      );
      _lastSyncedPositionById[id] = normalizedPositionMilliseconds;
      state = state.copyWith(
        isLoading: false,
        errorMessage: null,
        syncedPositionById: <String, int>{
          ...state.syncedPositionById,
          id: normalizedPositionMilliseconds,
        },
        completedIds: updatedCompletedIds,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: ErrorHandle.formatErrorMessage(e),
      );
    } finally {
      _syncingIds.remove(id);
    }
  }
}

final libraryProgressProvider =
    StateNotifierProvider<LibraryProgressProvider, LibraryProgressState>((ref) {
      return LibraryProgressProvider(
        resource: LibraryProgressRepository(
          resource: LibraryProgressApiService(apiClient: ApiClient()),
        ),
      );
    });
