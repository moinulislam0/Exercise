import 'package:flutter_riverpod/legacy.dart';

class LocalWatchProgress {
  final int positionMilliseconds;
  final bool isCompleted;

  const LocalWatchProgress({
    required this.positionMilliseconds,
    required this.isCompleted,
  });

  LocalWatchProgress copyWith({
    int? positionMilliseconds,
    bool? isCompleted,
  }) {
    return LocalWatchProgress(
      positionMilliseconds:
          positionMilliseconds ?? this.positionMilliseconds,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class LocalWatchProgressNotifier
    extends StateNotifier<Map<String, LocalWatchProgress>> {
  LocalWatchProgressNotifier() : super({});

  void updateProgress({
    required String id,
    required int positionMilliseconds,
  }) {
    final current = state[id];
    state = {
      ...state,
      id: (current ??
              const LocalWatchProgress(
                positionMilliseconds: 0,
                isCompleted: false,
              ))
          .copyWith(
        positionMilliseconds: positionMilliseconds,
        isCompleted: false,
      ),
    };
  }

  void markCompleted(String id) {
    final current = state[id];
    state = {
      ...state,
      id: (current ??
              const LocalWatchProgress(
                positionMilliseconds: 0,
                isCompleted: false,
              ))
          .copyWith(
        isCompleted: true,
      ),
    };
  }
}

final localWatchProgressProvider = StateNotifierProvider<
    LocalWatchProgressNotifier, Map<String, LocalWatchProgress>>((ref) {
  return LocalWatchProgressNotifier();
});
