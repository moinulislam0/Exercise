import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/subscription/view/widget/plan_row_widget.dart';

class PlanWidget extends StatelessWidget {
  final String? title;
  final String? price;
  final String? description;
  final String? featureHeader;
  final List<String>? features;
  final VoidCallback? onSelect;

  const PlanWidget({
    super.key,
    this.title,
    this.price,
    this.description,
    this.featureHeader,
    this.features,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorManager.backgroundColorgreen.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title (e.g. Platinum)
            Text(
              title ?? '',
              style: getMedium500Style10(
                color: ColorManager.textPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Price (e.g. $199.00/week)
            Text(
              price ?? '',
              style: getMedium500Style14(
                color: ColorManager.textPrimary,
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (featureHeader != null && featureHeader!.isNotEmpty)
              SizedBox(height: 8.h),
            // Description
            Text(
              description ?? '',
              style: getMedium500Style14(
                color: ColorManager.textPrimary,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (featureHeader != null && featureHeader!.isNotEmpty)
              SizedBox(height: 15.h),
            // Feature Header (e.g. Gym + Hydrotherapy)
            Text(
              featureHeader ?? "",
              style: getMedium500Style14(
                color: ColorManager.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (featureHeader != null && featureHeader!.isNotEmpty)
              SizedBox(height: 10.h),

            // Dynamic List of Features
            ...(features ?? []).map(
              (feature) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: PlanRowWidget(text: feature),
              ),
            ),
            if (featureHeader != null && featureHeader!.isNotEmpty)
              SizedBox(height: 20.h),
            // Button
            Customebutton(text: "Contact Clinic", onTap: onSelect),
          ],
        ),
      ),
    );
  }
}
