import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/favourite_screen/viewModel/favourite_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_brings/viewModel/personalization_provider.dart';

final selectedCategoryProvider = StateProvider<int?>((ref) => null);

class BottomsheetWidget extends ConsumerStatefulWidget {
  const BottomsheetWidget({super.key});

  @override
  ConsumerState<BottomsheetWidget> createState() => _BottomsheetWidgetState();
}

class _BottomsheetWidgetState extends ConsumerState<BottomsheetWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final notifier = ref.read(personalizationProvider.notifier);
      if ((notifier.personalizationData?.data ?? []).isEmpty) {
        notifier.getCategories();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedCategoryProvider);
    final personalizationState = ref.watch(personalizationProvider);
    final categories =
        ref.watch(personalizationProvider.notifier).personalizationData?.data ??
            [];
    final totalItems = categories.length;

    return Container(
      constraints: BoxConstraints(maxHeight: 650.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.playlistBox,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Image.asset(
            IconManager.upIcon,
            fit: BoxFit.cover,
            height: 20.h,
            width: 20.w,
          ),
          SizedBox(height: 10.h),
          Text(
            "Categories",
            style: getMedium500Style10(
              color: ColorManager.textPrimary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),
          Flexible(
            child: personalizationState.isLoading && categories.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : personalizationState.errorMessage != null
                    ? Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Text(
                          personalizationState.errorMessage!,
                          textAlign: TextAlign.center,
                          style: getMedium500Style14(
                            color: Colors.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: List.generate(totalItems, (index) {
                            final isSelected = selectedIndex == index;
                            final category = categories[index];
                            final title = category.title ?? '';

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 4.h,
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15.r),
                                onTap: () async {
                                  ref
                                      .read(selectedCategoryProvider.notifier)
                                      .state = index;
                                  await ref
                                      .read(favouriteProvider.notifier)
                                      .applyCategoryFilter(category.id);
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: isSelected ? 55.h : 30.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: isSelected
                                        ? ColorManager.bottomSheetColor
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.transparent
                                          : ColorManager.bottomSheetColor
                                              .withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        title,
                                        style: getMedium500Style14(
                                          color: ColorManager.textPrimary,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
