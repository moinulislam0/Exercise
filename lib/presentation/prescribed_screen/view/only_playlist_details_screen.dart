import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/data/models/prescription_details_model.dart'
    as detail_model;
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/favourite_screen/viewModel/favourite_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/favourite_id_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/prescribed_screen/viewModel/library_progress_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/prescribed_screen/viewModel/only_details_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/viewModel/profile_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/custom_video_player/Custom_video_player.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/workout_set/workOut_set.dart';

class OnlyPlaylistDetailsScreen extends ConsumerStatefulWidget {
  const OnlyPlaylistDetailsScreen({
    super.key,
    this.id,
    this.videoUrl,
    this.initialPositionMilliseconds = 0,
    this.fallbackTabIndex = 0,
  });

  final String? id;
  final String? videoUrl;
  final int initialPositionMilliseconds;
  final int fallbackTabIndex;

  @override
  ConsumerState<OnlyPlaylistDetailsScreen> createState() =>
      _OnlyPlaylistDetailsScreen();
}

class _OnlyPlaylistDetailsScreen
    extends ConsumerState<OnlyPlaylistDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isExpanded = false;
  String? _selectedVideoUrl;
  String? _selectedThumbnail;
  int? _selectedVideoIndex;
  int? _selectedPositionMilliseconds;
  final Map<String, bool> _favoriteOverrides = {};
  int _playRequestId = 0;
  late final LibraryProgressProvider _libraryProgressNotifier;
  late final ProfileProvider _profileNotifier;
  late final OnlyDetailsNotifier _onlyDetailsNotifier;

  @override
  void initState() {
    super.initState();
    _libraryProgressNotifier = ref.read(libraryProgressProvider.notifier);
    _profileNotifier = ref.read(profileProvider.notifier);
    _onlyDetailsNotifier = ref.read(onlyDetailsProvider.notifier);
    if (widget.initialPositionMilliseconds > 0) {
      _selectedPositionMilliseconds = widget.initialPositionMilliseconds;
    }
    Future.microtask(() {
      final id = widget.id;
      if (id != null && id.isNotEmpty) {
        _onlyDetailsNotifier.fetchPrescriptionDetails(id: id);
      }
    });
  }

  @override
  void dispose() {
    Future.microtask(() {
      _profileNotifier.profileData();
    });
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool> _handleBackNavigation() async {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
      return false;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.parentScreen,
      (route) => false,
      arguments: widget.fallbackTabIndex,
    );
    return false;
  }

  int _resolveSelectedVideoIndex({
    required List<detail_model.Videos> videos,
    required String? lastPlayedVideoId,
  }) {
    if (videos.isEmpty) {
      return 0;
    }
    if (_selectedVideoIndex != null &&
        _selectedVideoIndex! >= 0 &&
        _selectedVideoIndex! < videos.length) {
      return _selectedVideoIndex!;
    }
    final lastPlayedIndex = videos.indexWhere(
      (video) => video.id == lastPlayedVideoId,
    );
    return lastPlayedIndex >= 0 ? lastPlayedIndex : 0;
  }

  String _metricValue(String? value, String suffix) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return '-- $suffix';
    }
    return '$trimmed $suffix';
  }

  String _weightValue(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return '-- KG';
    }
    final upper = trimmed.toUpperCase();
    if (upper.endsWith('KG') || upper.endsWith('LB')) {
      return upper;
    }
    return '$trimmed KG';
  }

  Widget _buildMetricCard(String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            value,
            style: getMedium500Style12(
              color: ColorManager.textPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _showNoteDialog(String note) {
    showDialog<void>(
      context: context,
      barrierColor: ColorManager.blackColor.withValues(alpha: .3),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            padding: EdgeInsets.all(18.r),
            decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x29000000),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Prescription Note',
                        style: getMedium500Style12(
                          color: ColorManager.textPrimary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        height: 36.h,
                        width: 36.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE3E6ED)),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 18.sp,
                          color: ColorManager.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  note.isNotEmpty ? note : "No additional notes provided.",
                  style: getRegular400Style14(
                    color: ColorManager.subtextColorGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ).copyWith(height: 1.45),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildVideoWorkoutSets({
    required List<detail_model.Videos> videos,
    required int selectedVideoIndex,
  }) {
    return videos.asMap().entries.map((entry) {
      final video = entry.value;
      return Padding(
        padding: EdgeInsets.only(
          bottom: entry.key == videos.length - 1 ? 0 : 15.h,
        ),
        child: WorkoutSet(
          mainImage: video.thumbnailUrl ?? ImageManager.gymGuide,
          title: video.title ?? 'Workout Video',
          iconBgColor: entry.key == selectedVideoIndex
              ? ColorManager.backgroundColorgreen
              : null,
          borderColor: entry.key == selectedVideoIndex
              ? ColorManager.backgroundColorgreen1
              : null,
          ontap: () {
            setState(() {
              _selectedVideoIndex = entry.key;
              _selectedVideoUrl = video.url ?? widget.videoUrl;
              _selectedThumbnail = video.thumbnailUrl;
              _selectedPositionMilliseconds =
                  video.lastPlayedPosition ??
                  widget.initialPositionMilliseconds;
              _isExpanded = false;
            });
          },
        ),
      );
    }).toList();
  }

  Future<void> _handleBookmarkTap({
    required String videoId,
    required bool isBookmarked,
  }) async {
    try {
      await ref.read(favouriteIdProvider.notifier).favouriteId(id: videoId);
      if (!mounted) return;

      setState(() {
        _favoriteOverrides[videoId] = !isBookmarked;
      });

      await ref.read(favouriteProvider.notifier).getFavourite();
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Bookmark updated')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update bookmark')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailsState = ref.watch(onlyDetailsProvider);
    final playlistData = detailsState.getData?.data;
    final videos = playlistData?.videos ?? const <detail_model.Videos>[];

    if (detailsState.isloading) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            _handleBackNavigation();
          }
        },
        child: Scaffold(
          backgroundColor: ColorManager.primary,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Customebar(
                  text: "Watch Video",
                  ontap: () => _handleBackNavigation(),
                ),
              ),
            ),
          ),
          body: const Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (detailsState.errorMessage != null) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            _handleBackNavigation();
          }
        },
        child: Scaffold(
          backgroundColor: ColorManager.primary,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Customebar(
                  text: "Your Prescribed Video",
                  ontap: () => _handleBackNavigation(),
                ),
              ),
            ),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Text(
                detailsState.errorMessage!,
                textAlign: TextAlign.center,
                style: getMedium500Style12(
                  color: ColorManager.blackColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (playlistData == null || videos.isEmpty) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            _handleBackNavigation();
          }
        },
        child: Scaffold(
          backgroundColor: ColorManager.primary,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Customebar(
                  text: "Your Prescribed Video",
                  ontap: () => _handleBackNavigation(),
                ),
              ),
            ),
          ),
          body: Center(
            child: Text(
              "No data found.",
              style: getMedium500Style12(
                color: ColorManager.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }

    final effectiveSelectedVideoIndex = _resolveSelectedVideoIndex(
      videos: videos,
      lastPlayedVideoId: playlistData.lastPlayedVideoId,
    );
    final selectedVideo = videos[effectiveSelectedVideoIndex];
    final description = selectedVideo.description ?? '';
    final shortDescription = description.length > 126
        ? '${description.substring(0, 126)}... '
        : description;
    final categoryText = selectedVideo.category ?? 'All';
    final chapterCount = videos.length;
    final effectiveInitialPositionMilliseconds =
        _selectedPositionMilliseconds ??
        (widget.initialPositionMilliseconds > 0
            ? widget.initialPositionMilliseconds
            : selectedVideo.lastPlayedPosition ?? 0);
    final currentVideoUrl =
        _selectedVideoUrl ?? widget.videoUrl ?? selectedVideo.url ?? '';
    final currentThumbnail =
        _selectedThumbnail ??
        selectedVideo.thumbnailUrl ??
        ImageManager.gymGuide;
    final chapterWidgets = _buildVideoWorkoutSets(
      videos: videos,
      selectedVideoIndex: effectiveSelectedVideoIndex,
    );
    final note = selectedVideo.note?.trim() ?? '';
    final selectedVideoId = selectedVideo.id;
    final prescriptionId = playlistData.id;
    final isBookmarked = selectedVideoId != null
        ? (_favoriteOverrides[selectedVideoId] ??
              (selectedVideo.isFavorite ?? false))
        : false;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handleBackNavigation();
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.primary,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Customebar(
                text: "Watch Video",
                ontap: () => _handleBackNavigation(),
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorManager.primary, ColorManager.whiteColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: ColorManager.whiteColor,
                      border: Border.all(
                        color: ColorManager.backgroundColorgreen1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomVideoPlayer(
                            videoUrl: currentVideoUrl,
                            thumbnailAsset: currentThumbnail,
                            initialPositionMilliseconds:
                                effectiveInitialPositionMilliseconds,
                            playRequestId: _playRequestId,
                            onPositionChanged: (position) {
                              if (selectedVideoId == null ||
                                  selectedVideoId.isEmpty) {
                                return;
                              }
                              _selectedPositionMilliseconds = position;
                              _libraryProgressNotifier.syncProgress(
                                id: selectedVideoId,
                                positionMilliseconds: position,
                                prescriptionId: prescriptionId,
                              );
                            },
                            onPlaybackStopped: (position) {
                              _selectedPositionMilliseconds = position;
                              if (selectedVideoId == null ||
                                  selectedVideoId.isEmpty) {
                                return;
                              }
                              _libraryProgressNotifier.syncProgress(
                                id: selectedVideoId,
                                positionMilliseconds: position,
                                force: true,
                                prescriptionId: prescriptionId,
                              );
                            },
                            onCompleted: (position) {
                              _selectedPositionMilliseconds = position;
                              if (selectedVideoId == null ||
                                  selectedVideoId.isEmpty) {
                                return;
                              }
                              _libraryProgressNotifier.syncProgress(
                                id: selectedVideoId,
                                positionMilliseconds: position,
                                isCompleted: true,
                                force: true,
                                prescriptionId: prescriptionId,
                              );
                            },
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  categoryText,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: getMedium500Style14(
                                    color: ColorManager.subtextColorGrey,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              InkWell(
                                onTap:
                                    selectedVideoId == null ||
                                        selectedVideoId.isEmpty
                                    ? null
                                    : () => _handleBookmarkTap(
                                        videoId: selectedVideoId,
                                        isBookmarked: isBookmarked,
                                      ),
                                child: Opacity(
                                  opacity:
                                      selectedVideoId == null ||
                                          selectedVideoId.isEmpty
                                      ? 0.5
                                      : 1,
                                  child: Image.asset(
                                    IconManager.bookMark,
                                    height: 16.h,
                                    color: isBookmarked
                                        ? ColorManager.blackColor
                                        : ColorManager.subtextColorGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            selectedVideo.title ??
                                playlistData.title ??
                                'Back Mobility Program',
                            style: getMedium500Style12(
                              color: ColorManager.textPrimary,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          RichText(
                            text: TextSpan(
                              style: getRegular400Style14(
                                color: const Color.fromARGB(255, 92, 92, 92),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ).copyWith(height: 1.6, letterSpacing: 0.5),
                              children: [
                                TextSpan(
                                  text: _isExpanded
                                      ? description
                                      : shortDescription,
                                ),
                                if (description.length > 126)
                                  TextSpan(
                                    text: _isExpanded
                                        ? 'Read Less'
                                        : 'Read More',
                                    style: getMedium500Style14(
                                      color: ColorManager.backgroundColorgreen1,
                                      fontSize: 13.sp,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        setState(() {
                                          _isExpanded = !_isExpanded;
                                        });
                                      },
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              _buildMetricCard(
                                _metricValue(selectedVideo.reps, 'Reps'),
                              ),
                              SizedBox(width: 10.w),
                              _buildMetricCard(
                                _metricValue(selectedVideo.sets, 'Sets'),
                              ),
                              SizedBox(width: 10.w),
                              _buildMetricCard(
                                _weightValue(selectedVideo.weight),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),

                          InkWell(
                            onTap: () => _showNoteDialog(note),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info,
                                  size: 18.sp,
                                  color: ColorManager.titleText1,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'View Note',
                                  style: getMedium500Style14(
                                    color: ColorManager.titleText1,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: ColorManager.whiteColor,
                              border: Border.all(
                                color: ColorManager.backgroundColorgreen,
                                width: .5.w,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Workout Set",
                                        style: getMedium500Style12(
                                          color: ColorManager.textPrimary,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            IconManager.videoICon,
                                            fit: BoxFit.cover,
                                            height: 13.h,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            '${effectiveSelectedVideoIndex + 1}/$chapterCount videos',
                                            style: getMedium500Style16(
                                              color: ColorManager.textPrimary,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  if (chapterWidgets.isNotEmpty)
                                    ...chapterWidgets,
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Customebutton(
                            onTap: () {
                              if (_scrollController.hasClients) {
                                _scrollController.animateTo(
                                  0,
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeOut,
                                );
                              }
                              setState(() {
                                _selectedVideoUrl = currentVideoUrl;
                                _selectedThumbnail = currentThumbnail;
                                _selectedVideoIndex =
                                    effectiveSelectedVideoIndex;
                                _playRequestId++;
                              });
                            },
                            text: "Watch Now",
                            textColor: ColorManager.whiteColor,
                            color: ColorManager.blackColor,
                            sufImage: IconManager.playButton,
                            sufImageColor: ColorManager.whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 70.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
