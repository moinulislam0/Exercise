import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';

class PinFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  const PinFieldWidget({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    const int pinLength = 5;
    final horizontalGap = 4.w;

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalGap = pinLength * (horizontalGap * 2);
        final pinBoxWidth = (constraints.maxWidth - totalGap) / pinLength;

        return PinCodeTextField(
          maxLength: pinLength,
          keyboardType: TextInputType.number,
          controller: textController,
          hideCharacter: false,
          highlight: true,
          hasUnderline: false,
          wrapAlignment: WrapAlignment.spaceBetween,
          pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: horizontalGap),
          pinBoxWidth: pinBoxWidth.clamp(40.0, 55.w),
          pinBoxHeight: 50.h,
          pinBoxRadius: 12.r,
          pinBoxColor: Colors.transparent,
          defaultBorderColor: ColorManager.backgroundColorgreen1,
          hasTextBorderColor: ColorManager.backgroundColorgreen1,
          highlightColor: ColorManager.backgroundColorgreen1,
          pinTextStyle: TextStyle(
            color: ColorManager.subtextColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          onDone: (value) {
            debugPrint('Completed: $value');
          },
        );
      },
    );
  }
}
