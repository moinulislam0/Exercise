import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';

class InstructionWidget extends StatelessWidget {
  const InstructionWidget({
    super.key,
    this.id,
    required this.description,
    required this.points,
    this.onBegin,
  });

  final String? id;
  final String description;
  final List<String> points;
  final VoidCallback? onBegin;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w),
      backgroundColor: const Color.fromARGB(255, 83, 83, 83),
      child: Container(
        constraints: BoxConstraints(maxHeight: 430.h),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: ColorManager.primary,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              Text(
                "Instruction",
                style: getMedium500Style10(
                  color: ColorManager.textPrimary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15.h),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        style: getMedium500Style12(
                          color: const Color.fromARGB(255, 85, 85, 85),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (points.isNotEmpty) SizedBox(height: 15.h),
                      ...points.map(
                        (point) => Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                IconManager.checkIcon,
                                fit: BoxFit.cover,
                                height: 20.h,
                                width: 20.w,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  point,
                                  style: getMedium500Style12(
                                    color: ColorManager.textPrimary,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
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
              SizedBox(height: 16.h),
              Customebutton(
                onTap: () {
                  Navigator.of(context).pop();
                  onBegin?.call();
                },
                text: "I'm Ready — Begin",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
