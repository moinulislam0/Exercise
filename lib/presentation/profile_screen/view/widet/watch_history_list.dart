import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/utils.dart';
import 'package:touralie33_fo222668a7688/data/models/watch_history_model.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/viewModel/profile_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/prescribed_screen/viewModel/library_progress_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/play_list/playlist_screen_widget.dart';

class WatchHistoryList extends ConsumerWidget {
  const WatchHistoryList({
    super.key,
    this.showAll = false,
    this.showProgress = false,
    this.showCompleted = false,
  });

  final bool showAll;
  final bool showProgress;
  final bool showCompleted;

  int _normalizeStoredPositionMilliseconds(
    int rawPosition,
    int? durationHintSeconds,
  ) {
    if (rawPosition <= 0) {
      return 0;
    }
    if (durationHintSeconds != null && rawPosition <= durationHintSeconds + 5) {
      return rawPosition * 1000;
    }
    return rawPosition;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final progressState = ref.watch(libraryProgressProvider);
    final allItems = profileState.getData?.data ?? <WatchHistoryItem>[];

    final filteredItems = allItems.where((item) {
      final isCompleted = progressState.completedIds.contains(item.id) ||
          item.isCompleted == true ||
          (item.watchStatus ?? '').toUpperCase() == 'COMPLETED';
      final lastPlayedPosition =
          progressState.syncedPositionById[item.id] ??
          item.lastPlayedPosition ??
          0;
      if (showAll) return true;
      if (showCompleted) {
        return isCompleted;
      }
      if (showProgress) {
        return !isCompleted &&
            (((item.watchStatus ?? '').toUpperCase() == 'IN_PROGRESS') ||
                (lastPlayedPosition > 0));
      }
      return true;
    }).toList();

    if (profileState.isloading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (profileState.errormessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            profileState.errormessage!,
            textAlign: TextAlign.center,
            style: getMedium500Style12(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    if (filteredItems.isEmpty) {
      return Center(
        child: Text(
          "No watch history found",
          style: getMedium500Style12(
            color: ColorManager.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        final isCompleted = progressState.completedIds.contains(item.id) ||
            item.isCompleted == true ||
            (item.watchStatus ?? '').toUpperCase() == 'COMPLETED';
        final effectiveLastPlayedPosition =
            isCompleted
                ? 0
                : _normalizeStoredPositionMilliseconds(
                    progressState.syncedPositionById[item.id] ??
                        item.lastPlayedPosition ??
                        0,
                    item.duration,
                  );
        final buttonText = _getButtonText(
          item,
          effectiveLastPlayedPosition,
          progressState.completedIds.contains(item.id),
        );
        final isProgress = buttonText == "In Progress";

        return PlayListScreenWidget(
          id: item.id,
          image: item.thumbnailUrl ?? ImageManager.gymGuide,
          videoCount:
              "${item.chaptersCount ?? 0} video${(item.chaptersCount ?? 0) == 1 ? '' : 's'}",
          title: item.title ?? "Untitled",
          videoDuration: Utils.formatDurationLabel(item.duration),
          totalTime: item.level ?? "Beginner",
          buttonText: buttonText,
          sufImage: isProgress ? IconManager.playButton : null,
          buttonIconColor: isProgress ? Colors.black : Colors.white,
          colorbg: const Color(0XFFF5F9F1),
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutesName.prescibedDetailsScreen,
              arguments: {
                'id': item.id,
                'initialPositionMilliseconds': effectiveLastPlayedPosition,
              },
            );
          },
        );
      },
    );
  }

  String _getButtonText(
    WatchHistoryItem item,
    int lastPlayedPosition,
    bool isLocallyCompleted,
  ) {
    if (isLocallyCompleted ||
        item.isCompleted == true ||
        (item.watchStatus ?? '').toUpperCase() == 'COMPLETED') {
      return "Completed";
    }

    if ((item.watchStatus ?? '').toUpperCase() == 'IN_PROGRESS' ||
        lastPlayedPosition > 0) {
      return "In Progress";
    }

    return "Start Now";
  }
}
