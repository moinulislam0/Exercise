import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/notification/notification_screen.dart';

class Customebar extends StatelessWidget {
  final String? text;
  final String? icon;
  final bool showBackIcon;
  final VoidCallback? ontap;

  const Customebar({
    super.key,
    this.text,
    this.icon,
    this.showBackIcon = true, this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        showBackIcon
            ? InkWell(

                onTap:ontap ?? () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  icon ?? IconManager.arrowLeft,
                  height: 24.h,
                  width: 24.w,
                ),
              )
            : SizedBox(width: 24.w),
        Text(text ?? "",style: getMedium500Style12(color: ColorManager.textPrimary,fontSize: 18.sp,fontWeight: FontWeight.w600),),
        NotificationScreen()
      ],
    );
  }
}
