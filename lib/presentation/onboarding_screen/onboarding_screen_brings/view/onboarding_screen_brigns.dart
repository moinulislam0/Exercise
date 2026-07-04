import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_brings/viewModel/personalization_provider.dart';


final selectItemsProvider = StateProvider<List<String>>((ref) => []);

class OnboardingScreenBrigns extends ConsumerStatefulWidget {
  const OnboardingScreenBrigns({super.key});

  @override
  ConsumerState<OnboardingScreenBrigns> createState() => _OnboardingScreenBrignsState();
}

class _OnboardingScreenBrignsState extends ConsumerState<OnboardingScreenBrigns> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(personalizationProvider.notifier).getCategories();
    });
  }
  

  void _toggleSelection(String item) {
    final currentList = ref.read(selectItemsProvider);
    if (currentList.contains(item)) {
     
      final updated =
          currentList.where((element) => element != item).toList();
      ref.read(selectItemsProvider.notifier).state = updated;
      SharedPreferenceData.setOnboardingPersonalization(updated);
    } else {
    
      final updated = [...currentList, item];
      ref.read(selectItemsProvider.notifier).state = updated;
      SharedPreferenceData.setOnboardingPersonalization(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final personalizationState = ref.watch(personalizationProvider);
    final categoriesData =
        ref.watch(personalizationProvider.notifier).personalizationData?.data;

    final selectedItems = ref.watch(selectItemsProvider);

    final categories = (categoriesData ?? [])
        .map((e) => (e.title ?? '').trim())
        .where((title) => title.isNotEmpty)
        .toList();

    return Padding(
      padding: EdgeInsets.all(12.r),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "What brings you here ?",
              style: getMedium500Style20(
                  color: ColorManager.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp),
            ),
            SizedBox(height: 16.h),
            if (personalizationState.isLoading && categories.isEmpty)
              Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: const Center(child: CircularProgressIndicator()),
              )
            else if (personalizationState.errorMessage != null)
              Padding(
                padding: EdgeInsets.only(top: 24.h),
                child: Text(
                  personalizationState.errorMessage!,
                  style: getMedium500Style16(
                    color: ColorManager.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else
              Wrap(
                spacing: 16.w,
                runSpacing: 16.h,
                children: [
                  for (final title in categories)
                    _buildSelectableItem(title, selectedItems),
                ],
              ),
          ],
        ),
      ),
    );
  }


  Widget _buildSelectableItem(String title, List<String> selectedItems) {
    final bool isSelected = selectedItems.contains(title);
    
    return InkWell(
      onTap: () => _toggleSelection(title),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected 
              ? ColorManager.backgroundColorgreen 
              : ColorManager.buttonbgBrings, 
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
            child: Text(
              title,
              style: getMedium500Style16(
                  color: ColorManager.textPrimary, 
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
