import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String? hintText;
  final String? labelText; 
  final Widget? suffixIcon;
  final Widget? prefixIcon; 
  final VoidCallback? onTap;
  final Color? borderColor;
  final bool readonly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator; 
  final ValueChanged<String>? onChanged; 

  const CustomTextField({
    super.key,
    this.controller,
    this.obscureText = false,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.borderColor,
    this.readonly = false, 
    this.keyboardType,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField( 
      controller: widget.controller,
      obscureText: widget.obscureText,
      readOnly: widget.readonly,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      cursorColor: ColorManager.backgroundColorgreen,
      style: getMedium500Style14(color: Colors.black), 
      decoration: InputDecoration(
        hintText: widget.hintText ?? "Enter text...",
        labelText: widget.labelText,
        labelStyle: getMedium500Style14(color: ColorManager.hintTextColor),
        hintStyle: getMedium500Style14(
          color: ColorManager.hintTextColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon != null
            ? InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(50), 
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: widget.suffixIcon!,
                ),
              )
            : null,
        
     
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

    
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 1.5,
            color: widget.borderColor ?? ColorManager.borderColor,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r), 
          borderSide: BorderSide(
            color: ColorManager.backgroundColorgreen,
            width: 2.0,
          ),
        ),

     
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
    );
  }
}