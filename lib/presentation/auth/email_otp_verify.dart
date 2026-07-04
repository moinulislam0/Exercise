import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/email_otp_verify_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/forget_password/view/widget/customeApp.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/otp/view/widget/pinFieldWidget.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/successfull_screen/view/widget/dialog_widget.dart';

class EmailOtpVerify extends ConsumerStatefulWidget {
  final String email;
   EmailOtpVerify({required this.email});

  @override
  ConsumerState<EmailOtpVerify> createState() => _EmailOtpVerifyState();
}

class _EmailOtpVerifyState extends ConsumerState<EmailOtpVerify> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otpState = ref.watch(emailOtpVerifyProvider);
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: CustomeApp(
        text: "Change PassWord",
        onBackTap: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          const Divider(
            color: Color.fromARGB(255, 231, 232, 231),
            thickness: 1,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 90.h),
                    Text(
                      "Enter Verification Code ",
                      style: getMedium500Style20(
                          color: ColorManager.subtextColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "We have sent a code verificaiton to ",
                      style: getMedium500Style14(
                          color: ColorManager.subtextColor1,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "your email address",
                      style: getMedium500Style14(
                          color: ColorManager.subtextColor1,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .05),
                            blurRadius: 10.r,
                            spreadRadius: 2.r,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PinFieldWidget(textController: _textEditingController),
                            SizedBox(height: 15.h),
                            Customebutton(
  text: otpState.loading ? "Verifying..." : "Submit",
  onTap: otpState.loading 
    ? null 
    : () async {
        final success = await ref.read(emailOtpVerifyProvider.notifier).verifyOtpEmail(
          email: widget.email, 
          otp: _textEditingController.text.trim(),
        );

        if (success) {
         
          showDialog(
  context: context,
  barrierDismissible: true, 
  
  builder: (BuildContext context) {
    return DialogWidget();
  },
);
        } else {
      
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(otpState.errorMessage ?? "Verification Failed")),
          );
        }
      },
),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
