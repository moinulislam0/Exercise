import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class CustomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onSkipTap;

  const CustomeAppbar({super.key, this.onBackTap, this.onSkipTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          color: ColorManager.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onBackTap, 
                child: Image.asset(
                  IconManager.arrowLeft,
                  height: 24.h,
                  width: 24.w,
                ),
              ),
              GestureDetector(
                onTap: onSkipTap,
                child: Text(
                  "Skip",
                  style: getMedium500Style14(
                    color: ColorManager.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
