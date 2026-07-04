import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class CustomeApp extends StatelessWidget implements PreferredSizeWidget {
  final String? text;
  final VoidCallback? onBackTap; 

  const CustomeApp({super.key, this.onBackTap, this.text});

  @override
Widget build(BuildContext context) {
  return SafeArea(
    child: Container(
      height: preferredSize.height,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      color: ColorManager.primary,
      child: Stack(
        alignment: Alignment.center,
        children: [
  
          Positioned(
            left: 0,
            child: GestureDetector(
              onTap: onBackTap,
              child: Image.asset(
                IconManager.arrowLeft,
                height: 24.h,
                width: 24.w,
              ),
            ),
          ),
         
          Text(
            text ?? '',
            textAlign: TextAlign.center,
            style: getMedium500Style14(
              color: ColorManager.textPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          
        ],
      ),
    ),
  );
}

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}