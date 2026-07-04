import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class OnboardingScreenBirthday extends ConsumerStatefulWidget {
  const OnboardingScreenBirthday({super.key});

  @override
  ConsumerState<OnboardingScreenBirthday> createState() =>
      _OnboardingScreenBirthdayState();
}

class _OnboardingScreenBirthdayState
    extends ConsumerState<OnboardingScreenBirthday> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _MonthController  = TextEditingController();
  final TextEditingController _yearController  = TextEditingController();

  void _saveDobIfPossible() {
    final day = _dayController.text.trim();
    final month = _MonthController.text.trim();
    final year = _yearController.text.trim();
    if (day.isEmpty || month.isEmpty || year.isEmpty) return;

    final normalizedYear = year.length == 2 ? '20$year' : year;
    final formatted =
        '${normalizedYear.padLeft(4, '0')}-${month.padLeft(2, '0')}-${day.padLeft(2, '0')}';
    SharedPreferenceData.setOnboardingDateOfBirth(formatted);
  }

  @override
  void initState() {
    super.initState();
    _dayController.addListener(_saveDobIfPossible);
    _MonthController.addListener(_saveDobIfPossible);
    _yearController.addListener(_saveDobIfPossible);
  }

  @override
 void dispose() {
    _dayController.dispose();
    _MonthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary1,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80.h),
                Image.asset(ImageManager.birthday, width: 108.w, height: 108.h),
                SizedBox(height: 16.h),
                Text(
                  "What is your Birthday",
                  style: getMedium500Style16(
                    color: ColorManager.textPrimary,
                  ).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 90.h,
                      width: 95.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                        color: Colors.white,
                        border: Border.all(
                          width: .2.w,
                          color: ColorManager.background,
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _dayController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: getMedium500Style16(
                            color: ColorManager.textPrimary,
                            fontSize: 32.sp,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "DD",
                            hintStyle: getMedium500Style14(
                              color: ColorManager.backgroundColorgreen,
                              fontSize: 32.sp,
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        height: 90.h,
                      width: 95.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: 0.05,
                            ), 
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 4), 
                          ),
                        ],
                        color: Colors.white,
                        border: Border.all(
                          width: .2.w,
                          color: ColorManager.background,
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _MonthController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: getMedium500Style16(
                            color: ColorManager.textPrimary,
                            fontSize: 32.sp,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder
                                .none, 
                            hintText: "MM",
                            hintStyle: getMedium500Style14(
                              color: ColorManager.backgroundColorgreen,
                              fontSize: 32.sp,
                            ),
                            contentPadding:
                                EdgeInsets.zero, 
                          ),
                        ),
                      ),
                    ),
                    Container(
                 height: 90.h,
                      width: 95.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                    
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: 0.05,
                            ), 
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 4), 
                          ),
                        ],
                        color: Colors.white,
                        border: Border.all(
                          width: .2.w,
                          color: ColorManager.background,
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _yearController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: getMedium500Style16(
                            color: ColorManager.textPrimary,
                            fontSize: 32.sp,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder
                                .none,
                            hintText: "YY",
                            hintStyle: getMedium500Style14(
                              color: ColorManager.backgroundColorgreen,
                              fontSize: 32.sp,
                            ),
                            contentPadding:
                                EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
