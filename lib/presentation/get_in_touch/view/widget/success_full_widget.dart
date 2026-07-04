import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class SuccessfullWidget extends StatelessWidget {
  const SuccessfullWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
       insetPadding: EdgeInsets.symmetric(horizontal: 12.w), 
       backgroundColor: Colors.transparent,
      child: Container(
        height: 386.h,
        width: 363.w,
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding:  EdgeInsets.all(8.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageManager.success,fit: BoxFit.cover,width: 240.w,height: 240.h,),
              Text("Form Submission",style: getMedium500Style22(color: ColorManager.subtextColor,fontSize: 24.sp)),
              Text("SuccessFul!",style: getMedium500Style22(color: ColorManager.subtextColor,fontSize: 24.sp)),
             SizedBox(height: 10.h,),
              Text("Our representative will contact you soon with your inquiry. Thanks for your time!",
              textAlign: TextAlign.center,
              style: getMedium500Style16(color: const Color.fromARGB(255, 149, 149, 149)),),
              SizedBox(height: 8.h,),
              
            ],
          ),
        ),
      ),
    );
  }
}