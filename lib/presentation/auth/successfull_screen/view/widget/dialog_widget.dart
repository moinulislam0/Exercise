import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
       insetPadding: EdgeInsets.symmetric(horizontal: 12.w), 
       backgroundColor: Colors.transparent,
      child: Container(
        height: 446.h,
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
              Text("Password Update",style: getMedium500Style22(color: ColorManager.subtextColor,fontSize: 24.sp)),
              Text("Suceesfully",style: getMedium500Style22(color: ColorManager.subtextColor,fontSize: 24.sp),),
              Text("Your password has been updated successfully",
              textAlign: TextAlign.center,
              style: getMedium500Style16(color: const Color.fromARGB(255, 149, 149, 149)),),
              SizedBox(height: 8.h,),
              Customebutton(
                text: "Back to Login",
                onTap: () {
                  Navigator.pushReplacementNamed(context, RoutesName.signInScreen);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}