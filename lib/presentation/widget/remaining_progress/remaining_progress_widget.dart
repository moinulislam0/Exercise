import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/getPrescription_resume_provider.dart';

class RemainingProgressWidget extends ConsumerWidget {
  const RemainingProgressWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final data = ref.watch(getPrescriptionResumeProvider).prescriptionData;
    final int rawProgress = data?.data?.watchProgress ?? 0;
    final double progressValue = (rawProgress.clamp(0, 100)) / 100;
    return Padding(
      padding: EdgeInsets.all(13.r),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 8.h),
            decoration: BoxDecoration(
              color: ColorManager.backgroundColorgreen,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 78.w),
                  child: Text(
                    "Remaining progress",
                    style: getMedium500Style20(
                      color: ColorManager.subtextColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.only(right: 78.w),
                  child: Text(
                    "Great progress, buddy! Stay\nconsistent and keep up your\nfitness routine.",
                    style: getMedium500Style12(
                      color: ColorManager.subtextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.parentScreen,
                      arguments: 1,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111111),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Watch Now",
                          style: getMedium500Style16(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Image.asset(
                          IconManager.playButton,
                          width: 14.w,
                          height: 14.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -6.h,
            right: -13.w,
            child: Container(
              
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.primary,
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: CircularPercentIndicator(
                  radius: 33.r,
                  lineWidth: 6.w,
                  percent: progressValue,
                  backgroundColor: Colors.transparent,
            
                  progressColor: ColorManager.backgroundColorgreen1,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Container(
                    width: 54.w,
                    height: 54.h,
                    decoration: BoxDecoration(
                      color: ColorManager.backgroundColorgreen.withValues(alpha: .2),
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$rawProgress%',
                          style: getMedium500Style16(
                            color: ColorManager.subtextColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Progress",
                          style: getMedium500Style10(
                            color: ColorManager.subtextColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
