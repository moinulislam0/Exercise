import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/forget_password/view/widget/customeApp.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/otp/view/widget/pinFieldWidget.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/otp/viewmodel/otp_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String? email;
  const OtpScreen({super.key, this.email});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otpState = ref.watch(otpProvider);
    final email = widget.email?.trim() ?? "";

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: CustomeApp(
        text: "Verify OTP",
        onBackTap: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          const Divider(color: Color.fromARGB(255, 231, 232, 231), thickness: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  SizedBox(height: 90.h),
                  Text("Enter Verification Code", style: getMedium500Style20(fontSize: 24.sp, color: Colors.black,)),
                  SizedBox(height: 8.h),
                  Text("We have sent a code verification to", style: getMedium500Style14()),
                  Text(email.isNotEmpty ? email : "your email", style: getMedium500Style14()),
                  SizedBox(height: 30.h),
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                    ),
                    child: Column(
                      children: [
                        PinFieldWidget(textController: _textEditingController),
                        SizedBox(height: 15.h),
                        if (otpState.isLoading || _isSubmitting)
                          const CircularProgressIndicator()
                        else
                          Customebutton(
                            text: "Submit",
                            onTap: () async {
                              final token = _textEditingController.text.trim();
                              if (email.isEmpty || token.isEmpty) return;

                              setState(() => _isSubmitting = true);
                              
                              final ok = await ref.read(otpProvider.notifier).verifyOtp(
                                email: email,
                                token: token,
                              );

                              setState(() => _isSubmitting = false);

                              if (ok) {
                                if (!context.mounted) return;
                       
                                final resolvedToken = ref.read(otpProvider).resetToken ?? token;
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.newPasswordScreen,
                                  arguments: {'email': email, 'token': resolvedToken},
                                );
                              } else {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(ref.read(otpProvider).errorMessage ?? 'Invalid OTP')),
                                );
                              }
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}