import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

// Provider for Height Unit
final heightUnitProvider = StateProvider<String>((ref) => "feet");

class OnboardingScreenHeight extends ConsumerStatefulWidget {
  const OnboardingScreenHeight({super.key});

  @override
  ConsumerState<OnboardingScreenHeight> createState() => _OnboardingScreenHeightState();
}

class _OnboardingScreenHeightState extends ConsumerState<OnboardingScreenHeight> {

  final TextEditingController _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _heightController.addListener(() {
      SharedPreferenceData.setOnboardingHeight(_heightController.text.trim());
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SharedPreferenceData.setOnboardingHeightUnit(ref.read(heightUnitProvider));
      SharedPreferenceData.setOnboardingHeight(_heightController.text.trim());
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedUnit = ref.watch(heightUnitProvider);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: bottomInset),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 80.h),
                        Image.asset(
                          IconManager.heightIcon,
                          width: 108.w,
                          height: 108.h,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "What is your height",
                          style: getMedium500Style16(
                            color: ColorManager.textPrimary,
                          ).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 40.h),
                        Container(
                          height: 40.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: ColorManager.bgColorgrey,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      ref.read(heightUnitProvider.notifier).state = "feet";
                                      SharedPreferenceData.setOnboardingHeightUnit("feet");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: selectedUnit == "feet"
                                            ? ColorManager.backgroundColorgreen
                                            : Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Feet",
                                          style: getMedium500Style14(
                                            color: ColorManager.textPrimary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      ref.read(heightUnitProvider.notifier).state = "cm";
                                      SharedPreferenceData.setOnboardingHeightUnit("cm");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: selectedUnit == "cm"
                                            ? ColorManager.backgroundColorgreen
                                            : Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "CM",
                                          style: getMedium500Style14(
                                            color: ColorManager.textPrimary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height: 55.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey.shade300, width: 1.5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 60.w,
                                child: TextField(
                                  controller: _heightController,//
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.right,
                                  style: getMedium500Style16(color: ColorManager.textPrimary),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "00",
                                    hintStyle: getMedium500Style14(
                                      color: ColorManager.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                  "|",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50.w,
                                child: Text(
                                  selectedUnit,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
