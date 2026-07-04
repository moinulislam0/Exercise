import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/forget_password/view/widget/customeApp.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/forget_password/viewmodel/forgot_password_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customTextField.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final forgotState = ref.watch(forgotPasswordProvider);

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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight, 
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, 
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 90.h), 
                            Text(
                              "Send an OTP",
                              style: getMedium500Style20(
                                  color: ColorManager.subtextColor,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Enter your mail address to",
                              style: getMedium500Style14(
                                  color: ColorManager.subtextColor1,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "reset your password",
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
                                    color: Colors.black.withValues(alpha: 0.05),
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
                                    Text(
                                      "Email Address",
                                      style: getMedium500Style14(
                                        color: ColorManager.textPrimary,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomTextField(
                                      controller: emailController,
                                      hintText: "alexa.mate@example.com",
                                    ),
                                    SizedBox(height: 20.h),
                                    if (forgotState.isLoading)
                                      const Center(child: CircularProgressIndicator())
                                    else
                                      Customebutton(
                                        text: "Send OTP",
                                        onTap: () async {
                                          final email = emailController.text.trim();
                                          if (email.isEmpty) return;

                                          final ok = await ref
                                              .read(forgotPasswordProvider.notifier)
                                              .forgotPass(email: email);

                                          if (!ok) {
                                            if (!context.mounted) return;
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  ref.read(forgotPasswordProvider).errorMessage ??
                                                      'Failed to send OTP',
                                                ),
                                              ),
                                            );
                                            return;
                                          }

                                          if (!context.mounted) return;
                                          Navigator.pushNamed(
                                            context,
                                            RoutesName.otpScreen,
                                            arguments: email,
                                          );
                                        },
                                      )
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(), 
                            SizedBox(height: 50.h), 
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
