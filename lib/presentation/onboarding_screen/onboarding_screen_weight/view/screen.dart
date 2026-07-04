import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';


final weightUnitProvider = StateProvider<String>((ref) => "Kg");

class OnBordingScreenWeight extends ConsumerStatefulWidget {
  const OnBordingScreenWeight({super.key});

  @override
  ConsumerState<OnBordingScreenWeight> createState() => _OnBordingScreenWeightState();
}

class _OnBordingScreenWeightState extends ConsumerState<OnBordingScreenWeight> {
  final TextEditingController _weightController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _weightController.addListener(() {
      SharedPreferenceData.setOnboardingWeight(_weightController.text.trim());
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SharedPreferenceData.setOnboardingWeight(_weightController.text.trim());
      SharedPreferenceData.setOnboardingWeightUnit(ref.read(weightUnitProvider));
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedUnit = ref.watch(weightUnitProvider);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: bottomInset),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h),
                  Image.asset(
                    ImageManager.weight,
                    width: 108.w,
                    height: 108.h,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "What is your Weight",
                    style: getMedium500Style16(
                      color: ColorManager.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 40.h),
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
                            controller: _weightController,
                            keyboardType: TextInputType.number,
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
                  SizedBox(height: 30.h),
                  Container(
                    height: 35.h,
                    width: 110.w,
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
                                ref.read(weightUnitProvider.notifier).state = "Kg";
                                SharedPreferenceData.setOnboardingWeightUnit("Kg");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: selectedUnit == "Kg"
                                      ? ColorManager.backgroundColorgreen
                                      : Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    "Kg",
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
                                ref.read(weightUnitProvider.notifier).state = "Lb";
                                SharedPreferenceData.setOnboardingWeightUnit("Lb");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: selectedUnit == "Lb"
                                      ? ColorManager.backgroundColorgreen
                                      : Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    "Lb",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
