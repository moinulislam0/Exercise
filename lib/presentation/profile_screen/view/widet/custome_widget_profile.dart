import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class CustomeWidgetProfile extends StatelessWidget {
  final String? title;
  final String? value;
  const CustomeWidgetProfile({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: const Color.fromARGB(255, 236, 243, 227)
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 14.h),
        child: Column(
          children: [
            Text(title?? "",style: getMedium500Style12(color: const Color.fromARGB(255, 121, 121, 121),fontSize: 14.sp,fontWeight: FontWeight.w500),),
            SizedBox(height: 8.h,),
            Text(value ?? '',style: getMedium500Style14(color: ColorManager.textPrimary,fontSize: 18.sp,fontWeight: FontWeight.w700))
          ],
        ),
      ),
    );
  }
}