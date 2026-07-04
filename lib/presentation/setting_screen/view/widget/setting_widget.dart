import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

final genderIndexProvider = StateProvider<int>((ref) => 0);

class SettingWidgetGender extends ConsumerWidget {
  const SettingWidgetGender ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(genderIndexProvider);
    final List<String> options = ["Male", "Female", "Other"];

    return Container(
  
      width: double.infinity, 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: ColorManager.beginerColor.withValues(alpha: 0.5),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        child: Row(
          mainAxisSize: MainAxisSize.max, 
          children: List.generate(options.length, (index) {
            final isSelected = selectedIndex == index;

            return Expanded(
              child: InkWell(
                onTap: () => ref.read(genderIndexProvider.notifier).state = index,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.r),
                    color: isSelected
                        ? ColorManager.backgroundColorgreen
                        : Colors.transparent,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h), 
                    child: Text(
                      options[index],
                      textAlign: TextAlign.center,
                      style: getMedium500Style16(
                        color: isSelected? ColorManager.textPrimary : const Color.fromARGB(255, 112, 112, 112),
                        fontSize: 14.sp,
                      ).copyWith( 
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}