import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class PlanRowWidget extends StatelessWidget {
  final String? text;
  const PlanRowWidget({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(IconManager.checkMark,height: 18.h,width: 18.w,fit: BoxFit.cover,),
        SizedBox(width: 8.w,),
        Expanded(
          child: Text(text ?? '',
          softWrap: true,
              
          
          style: getMedium500Style10(fontSize: 14.sp,color: ColorManager.textPrimary),),
        )
      ],
    );
  }
}