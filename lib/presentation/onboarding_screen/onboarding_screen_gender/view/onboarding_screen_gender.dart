import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';

final selectItem = StateProvider<bool>((ref)=>true);

class OnboardingScreenGender extends ConsumerStatefulWidget {
  const OnboardingScreenGender({super.key});

  @override
  ConsumerState<OnboardingScreenGender> createState() =>
      _OnboardingScreenGenderState();
}

class _OnboardingScreenGenderState
    extends ConsumerState<OnboardingScreenGender> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isMale = ref.read(selectItem);
      SharedPreferenceData.setOnboardingGender(isMale ? 'male' : 'female');
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemselect = ref.watch(selectItem);
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
                Image.asset(ImageManager.gender, width: 108.w, height: 108.h),
                SizedBox(height: 16.h),
                Text(
                  "What is your Gender",
                  style: getMedium500Style16(
                    color: ColorManager.textPrimary,
                  ).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 40.h),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Expanded(
                     child: InkWell(
                     onTap: () {
                        ref.read(selectItem.notifier).state = true;
                        SharedPreferenceData.setOnboardingGender('male');
                      },
                       child: Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: itemselect? ColorManager.backgroundColorgreen : ColorManager.backgroundColorgreen.withValues(alpha: .2),
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             
                              Image.asset(IconManager.male,width: 60.w,height: 73.h, color: itemselect ? ColorManager.drawrColor : ColorManager.whiteColor,),
                              Text("Male",style: getMedium500Style14(color:itemselect ? Colors.white : ColorManager.backgroundColorgreen),)
                            ],
                          ),
                        ),
                       ),
                     ),
                   ),
                   SizedBox(width: 20.w,),
                   Expanded(
                     child: InkWell(
                     onTap: () {
                        ref.read(selectItem.notifier).state = false;
                        SharedPreferenceData.setOnboardingGender('female');
                      },
                       child: Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: !itemselect? ColorManager.backgroundColorgreen : ColorManager.backgroundColorgreen.withValues(alpha: .2),
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             
                              Image.asset(IconManager.female,width: 60.w,height: 73.h,color: !itemselect ? ColorManager.drawrColor : ColorManager.whiteColor,),
                              Text("FeMale",style: getMedium500Style14(color:!itemselect ? Colors.white : ColorManager.backgroundColorgreen),)
                            ],
                          ),
                        ),
                       ),
                     ),
                   ),
                 ],
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
