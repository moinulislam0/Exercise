import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/utils.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/getPrescription_resume_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/prescribed_screen/view/only_playlist_details_screen.dart';

class WorkoutWidget extends ConsumerWidget {
  const WorkoutWidget({super.key, this.id});

  final String? id;

  // void _openInstructionDialog({
  //   required BuildContext context,
  //   String? id, 
  //   required String description,
  //   required List<String> points,
  //   String? videoUrl,
  // }) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => InstructionWidget(
  //       description: description,
  //       points: points,
  //       onBegin: () {
  //         Navigator.pop(context);

  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => OnlyPlaylistDetailsScreen(
  //               id: id,
  //               fallbackTabIndex: 0,
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptionState = ref.watch(getPrescriptionResumeProvider);
    final workout = prescriptionState.prescriptionData?.data;

    final workoutId = workout?.prescriptionId ?? workout?.id ?? id;
    
   // final instruction = workout?.instruction;
    final imageUrl = workout?.thumbnail;
   // final videoUrl = workout?.url;
    final canOpenDetails = (workoutId ?? '').trim().isNotEmpty;
   // final points = instruction?.points ?? const <String>[];
    //final description = instruction?.description ??
        workout?.progressMessage ??
        'No instruction available right now.';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: ColorManager.primary,
        border: Border.all(
          width: 1,
          color: ColorManager.backgroundColorgreen.withValues(alpha: .5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: prescriptionState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : prescriptionState.errorMessage != null
                ? Text(
                    prescriptionState.errorMessage!,
                    style: getMedium500Style12(
                      color: ColorManager.subtextColor,
                      fontSize: 14.sp,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today's Workout",
                            style: getMedium500Style12(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                IconManager.clock,
                                height: 16.h,
                                color: ColorManager.blackColor,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                Utils.formatDurationLabel(workout?.duration),
                                style: getMedium500Style14(
                                  color: ColorManager.blackColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        workout?.title ?? "Today's Workout",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getMedium500Style14(
                          color: ColorManager.subtextColor,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                IconManager.videoICon,
                                fit: BoxFit.cover,
                                height: 14.h,
                                width: 14.w,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '${workout?.chapterCount ?? 0} Videos',
                                style: getMedium500Style14(
                                  color: ColorManager.subtextColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if ((workout?.progressMessage ?? '').trim().isNotEmpty) ...[
                        SizedBox(height: 8.h),
                        Text(
                          workout!.progressMessage!,
                          style: getMedium500Style14(
                            color: ColorManager.subtextColorGrey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                      SizedBox(height: 15.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: GestureDetector(
                          onTap: !canOpenDetails
                              ? null
                              :() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OnlyPlaylistDetailsScreen(
                                        id: workoutId,
                                        fallbackTabIndex: 0,
                                      ),
                                    ),
                                  ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              imageUrl != null && imageUrl.startsWith('http')
                                  ? Image.network(
                                      imageUrl,
                                      width: double.infinity,
                                      height: 220.h,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Image.asset(
                                        ImageManager.gymGuide,
                                        width: double.infinity,
                                        height: 220.h,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset(
                                      ImageManager.gymGuide,
                                      width: double.infinity,
                                      height: 220.h,
                                      fit: BoxFit.cover,
                                    ),
                              SizedBox(
                                width: 80.w,
                                height: 80.h,
                                child: Image.asset(IconManager.playCircle),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Customebutton(
                        onTap: !canOpenDetails
                            ? () {}
                            : () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OnlyPlaylistDetailsScreen(
                                      id: workoutId,
                                      fallbackTabIndex: 0,
                                    ),
                                  ),
                                ),
                        text: "Watch Now",
                        sufImage: IconManager.playButton,
                        sufImageColor: ColorManager.blackColor,
                      ),
                    ],
                  ),
      ),
    );
  }
}
