import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
class WorkoutSet extends StatelessWidget {
  final String? mainImage;
  final String? title;
  final String? duration;
  final String? clockIcon;
  final String? actionIcon;
  final Color? iconBgColor, borderColor, iconPlatbgColor;
  final VoidCallback? ontap;

  const WorkoutSet({
    super.key,
    this.mainImage,
    this.title,
    this.duration,
    this.clockIcon,
    this.actionIcon,
    this.iconBgColor,
    this.borderColor,
    this.iconPlatbgColor,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final hasDuration = (duration ?? '').trim().isNotEmpty;

    return InkWell(
      onTap:ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor?? ColorManager.subtextColorGrey, width: 1.w),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    if ((mainImage ?? '').startsWith('http'))
                      Image.network(
                        mainImage!,
                        height: 58.h,
                        width: 58.w,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      )
                    else
                      Image.asset(mainImage ?? '', height: 58.h, width: 58.w),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: hasDuration
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          Text(
                            title ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getMedium500Style14(
                              color: ColorManager.textPrimary,
                              fontSize: 14.sp,
                            ),
                          ),
                          if (hasDuration) ...[
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Image.asset(
                                  clockIcon ?? IconManager.clock,
                                  fit: BoxFit.cover,
                                  height: 13.h,
                                  width: 11.w,
                                ),
                                SizedBox(width: 4.w),
                                Flexible(
                                  child: Text(
                                    duration ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: getMedium500Style10(
                                      color: ColorManager.subtextColorGrey,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                height: 31.h,
                width: 31.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconBgColor ?? const Color.fromARGB(255, 207, 207, 207),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    actionIcon ?? IconManager.playButton,
                    color: iconPlatbgColor ?? ColorManager.blackColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
