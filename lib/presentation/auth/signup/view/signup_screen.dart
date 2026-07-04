import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/email_otp_verify.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customTextField.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signup/viewmodel/signup_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

final eyeSecure = StateProvider<bool>((ref) => false);
final checkIcon = StateProvider<bool>((ref) => false);

class SingInUpScreen extends ConsumerStatefulWidget {
  const SingInUpScreen({super.key});

  @override
  ConsumerState<SingInUpScreen> createState() => _SingInUpScreenState();
}

class _SingInUpScreenState extends ConsumerState<SingInUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEyeon = ref.watch(eyeSecure);
    final isCheck = ref.watch(checkIcon);
    final signUpState = ref.watch(signUpViewModelProvider);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorManager.primary, ColorManager.primarygrey],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60.h),
                Text(
                  "Sign Up",
                  style: getMedium500Style22(
                    color: ColorManager.textPrimary,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Enter your details below to create your account",
                  style: getMedium500Style14(
                    color: Color.fromARGB(255, 149, 149, 149),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 38.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .05),
                        blurRadius: 10.r,
                        spreadRadius: 2.r,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: getMedium500Style14(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          controller: _nameController,
                          hintText: "alexa mate",
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Email Address",
                          style: getMedium500Style14(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          controller: _emailController,
                          hintText: "alexa.mate@example.com",
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Password",
                          style: getMedium500Style14(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: "enter your password",
                          obscureText: !isEyeon,
                          suffixIcon: IconButton(
                            onPressed: () {
                              ref.read(eyeSecure.notifier).state = !isEyeon;
                            },
                            icon: Icon(
                              isEyeon ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    ref.read(checkIcon.notifier).state =
                                        !isCheck;
                                  },
                                  child: Container(
                                    height: 18.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.r),
                                      color: isCheck
                                          ? ColorManager.backgroundColorgreen1
                                          : null,
                                      border: Border.all(
                                        color: isCheck
                                            ? ColorManager.background
                                            : ColorManager.backgroundColorgreen,
                                      ),
                                    ),
                                    child: isCheck
                                        ? Center(
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 20.sp,
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Row(
                                  children: [
                                    Text(
                                      "I Accept the",
                                      style: getMedium500Style14(
                                        color: ColorManager.textPrimary,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final Uri url = Uri.parse(
                                          'https://www.dashboard.irclinic.com.au/legal/terms-and-condition',
                                        );
                                        if (!await launchUrl(
                                          url,
                                          mode: LaunchMode.externalApplication,
                                        )) {
                                          throw Exception(
                                            'Could not launch $url',
                                          );
                                        }
                                      },
                                      child: Text(
                                        "Terms & Conditions",
                                        style: getMedium500Style14(
                                          color: ColorManager.textPrimary,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Customebutton(
                          text: signUpState.isLoading
                              ? "Signing Up..."
                              : "Sign Up",
                          onTap: signUpState.isLoading
                              ? null
                              : () async {
                                  if (!isCheck) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Please accept the Terms & Conditions',
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  final success = await ref
                                      .read(signUpViewModelProvider.notifier)
                                      .signup(
                                        name: _nameController.text.trim(),
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text,
                                      );
                                  if (!mounted) return;
                                  if (success) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EmailOtpVerify(
                                          email: _emailController.text.trim(),
                                        ),
                                      ),
                                      (route) => false,
                                    );
                                  } else {
                                    final msg =
                                        ref
                                            .read(signUpViewModelProvider)
                                            .errorMessage ??
                                        'Sign up failed';
                                    log('Signup UI error: $msg');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(msg)),
                                    );
                                  }
                                },
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        ImageManager.vertical,
                        fit: BoxFit.fitWidth,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "Or Sign Up With",
                        style: getMedium500Style14(
                          color: ColorManager.subtextColor,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Image.asset(
                        ImageManager.vertical,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Customebutton(
                //   image: IconManager.google,
                //   text: "SignUp With Google",
                //   color: Colors.white,
                //   borderColor: const Color.fromARGB(255, 235, 235, 235),
                //   border: 1.2.w,
                // ),
                // SizedBox(height: 8.h),
                // Customebutton(
                //   image: IconManager.facebook,
                //   text: "SignUP With Facebook",
                //   color: Colors.white,
                //   borderColor: const Color.fromARGB(255, 235, 235, 235),
                //   border: 1.5.w,
                // ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't have an account ?",
                      style: getMedium500Style16(
                        color: ColorManager.subtextColor,
                        fontSize: 14.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesName.signInScreen,
                        );
                      },
                      child: Text(
                        "Login",
                        style: getMedium500Style16(
                          color: ColorManager.drawrColor,//
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
