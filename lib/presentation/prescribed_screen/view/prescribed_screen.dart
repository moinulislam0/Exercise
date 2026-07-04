import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/workout_set/workOut_set.dart';

class PrescribedScreen extends StatefulWidget {
 
  const PrescribedScreen({super.key,});

  @override
  State<PrescribedScreen> createState() => _PrescribedScreenState();
}

class _PrescribedScreenState extends State<PrescribedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(text: "Your Prescribed Video"),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Container(
          width: 343.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: ColorManager.whiteColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Workout Set",
                      style: getMedium500Style12(
                        color: ColorManager.textPrimary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(IconManager.videoICon, height: 14.h),
                        SizedBox(width: 5.w),
                        Text(
                          "1/4 Videos",
                          style: getMedium500Style14(
                            color: ColorManager.textPrimary,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                WorkoutSet(
                   ontap: (){
                     Navigator.pushReplacementNamed(context, RoutesName.prescibedDetailsScreen);
                  },
                  title: "Introduction to the class",
                  duration: "10 min",
                  mainImage: ImageManager.gymGuide,
                  borderColor: ColorManager.backgroundColorgreen,
                  iconBgColor: ColorManager.backgroundColorgreen,
                ),
                SizedBox(height: 15.h),
                WorkoutSet(
                  ontap: (){
                     Navigator.pushReplacementNamed(context, RoutesName.prescibedDetailsScreen);
                  },
                  title: "Introduction to the class",
                  duration: "10 min",
                  mainImage: ImageManager.gymGuide,
                  iconPlatbgColor: ColorManager.subtextColorGrey,
                ),
                SizedBox(height: 15.h),
                WorkoutSet(
                   ontap: (){
                     Navigator.pushReplacementNamed(context, RoutesName.prescibedDetailsScreen);
                  },
                  title: "Introduction to the class",
                  duration: "10 min",
                  mainImage: ImageManager.gymGuide,
                  iconPlatbgColor: ColorManager.subtextColorGrey,
                ),
                SizedBox(height: 15.h),
                WorkoutSet(
                   ontap: (){
                     Navigator.pushReplacementNamed(context, RoutesName.prescibedDetailsScreen);
                  },
                  title: "Introduction to the class",
                  duration: "10 min",
                  mainImage: ImageManager.gymGuide,
                  iconPlatbgColor: ColorManager.subtextColorGrey,
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
