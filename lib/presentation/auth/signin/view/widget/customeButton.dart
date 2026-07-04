import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class Customebutton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  final Color? color;
  final String? image,sufImage; 
  final Color? borderColor;
  final Color? textColor,sufImageColor;
  final double? border;

  const Customebutton({
    super.key,
    this.text,
    this.onTap,
    this.color,
    this.image, this.borderColor, this.border, this.textColor, this.sufImage, this.sufImageColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? ColorManager.backgroundColorgreen,
            width: border ?? 0,
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: color ?? ColorManager.backgroundColorgreen,
        ),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
          
            if (image != null) ...[
              Image.asset(
                image!, 
                width: 20.w, 
                height: 20.h,
              ),
              SizedBox(width: 10.w), 
            ],
            
            Text(
              text ?? "Button",
              style: getMedium500Style16(
                color:textColor?? ColorManager.subtextColor,
                fontSize: 16.sp,
                fontWeight:  FontWeight.w500,
              ),
            ),
            SizedBox(width: 15.w,),
              if (sufImage != null) ...[
              Image.asset(
                sufImage!, 
                width: 20.w, 
                height: 20.h,
                color: sufImageColor,
              ),
              SizedBox(width: 10.w), 
            ],
          ],
        ),
      ),
    );
  }
}