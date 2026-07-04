import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class NotificationWidget extends StatelessWidget {
  final String? title, description, time;
  final bool isRead;
  const NotificationWidget({
    super.key,
    this.title,
    this.description,
    this.time,
    this.isRead = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isRead ? Colors.transparent : const Color(0xFFFFF1F1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                IconManager.notificationIcon,
                height: 24.h,
                width: 24.w,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title ?? "",
                      style: getLight300Style12(
                        fontSize: 14.sp,
                        fontWeight: isRead ? FontWeight.w500 : FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description ?? '',
                      style: getLight300Style12(
                        color: ColorManager.subtextColorGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      softWrap: true,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      time ?? '',
                      style: getLight300Style12(
                        color: ColorManager.subtextColorGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: isRead ? 0 : 1,
                child: Container(
                  margin: EdgeInsets.only(top: 6.h),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE85D5D),
                  ),
                  height: 8.h,
                  width: 8.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
