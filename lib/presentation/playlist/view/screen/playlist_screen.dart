import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/data/models/prescribed_model.dart';
import 'package:touralie33_fo222668a7688/presentation/playlist/viewModel/prescribed_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/prescribed_screen/view/only_playlist_details_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/play_list/playlist_screen_widget.dart';

class PlaylistScreen extends ConsumerStatefulWidget {
  const PlaylistScreen({super.key});

  @override
  ConsumerState<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends ConsumerState<PlaylistScreen> {
  String _formatDate(String? rawDate) {
    if (rawDate == null || rawDate.trim().isEmpty) {
      return '';
    }

    final parsedDate = DateTime.tryParse(rawDate);
    if (parsedDate == null) {
      return rawDate;
    }

    return DateFormat('dd MMM yyyy').format(parsedDate);
  }

  @override
  void initState() {
    Future.microtask(() {
      ref.read(prescribedProvider.notifier).fetchPrescribed();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prescribedState = ref.watch(prescribedProvider);
    final List<PrescriptionData> prescribed = prescribedState.data?.data ?? [];

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(text: "Playlist", showBackIcon: false),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Divider(),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                "Watch your remaining prescribed videos",
                style: getMedium500Style12(
                  color: ColorManager.blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            if (prescribedState.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (prescribedState.errorMessage != null)
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Center(
                  child: Text(
                    prescribedState.errorMessage!,
                    textAlign: TextAlign.center,
                    style: getMedium500Style12(
                      color: ColorManager.blackColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            else if (prescribed.isEmpty)
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Center(
                  child: Text(
                    "No data found.",
                    style: getMedium500Style12(
                      color: ColorManager.blackColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            else
              ...prescribed.map(_buildPlaylistItem),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaylistItem(PrescriptionData data) {
    final buttonText = _getButtonText(data);
    final totalVideos = data.totalVideos ?? 0;
    final completedVideos = data.totalCompletedVideos ?? 0;

    return PlayListScreenWidget(
      id: data.id,
      image: data.thumbnailUrl ?? ImageManager.gymGuide,
      videoCount: "$completedVideos/$totalVideos videos",
      title: data.title ?? "",
      videoDuration: "$totalVideos video${totalVideos == 1 ? '' : 's'}",
      totalTime: _formatDate(data.createdAt),
      buttonText: buttonText,
      buttonIconColor: Colors.white,
      onTap:  () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OnlyPlaylistDetailsScreen(
              id: data.id,
              fallbackTabIndex: 1,
            ),
          ),
        );
      }
        
    );
  }

  String _getButtonText(PrescriptionData data) {
    if ((data.totalCompletedVideos ?? 0) >= (data.totalVideos ?? 0) &&
        (data.totalVideos ?? 0) > 0) {
      return "Completed";
    }

    if ((data.watchStatus ?? '').toUpperCase() == 'IN_PROGRESS') {
      return "In Progress";
    }

    return "Start Now";
  }
}
