import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/forget_password/view/widget/customeApp.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/new_password_screen/viewModel/resetPassword_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customTextField.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/successfull_screen/view/widget/dialog_widget.dart';

class NewPasswordScreen extends ConsumerStatefulWidget {
  final String? email;
  final String? token;

  const NewPasswordScreen({super.key, this.email, this.token});

  @override
  ConsumerState<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends ConsumerState<NewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isEyeOn = false;
  bool _isEyeOn1 = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resetState = ref.watch(resetPasswordProvider);

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: CustomeApp(text: "Change Password", onBackTap: () => Navigator.pop(context)),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorManager.primary, ColorManager.primarygrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Text("Enter New Password", style: getMedium500Style22(fontSize: 24.sp,color: Colors.black)),
              SizedBox(height: 40.h),
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("New Password"),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Enter password",
                      obscureText: !_isEyeOn,
                      suffixIcon: IconButton(
                        icon: Icon(_isEyeOn ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _isEyeOn = !_isEyeOn),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    const Text("Confirm Password"),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: "Re-enter password",
                      obscureText: !_isEyeOn1,
                      suffixIcon: IconButton(
                        icon: Icon(_isEyeOn1 ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _isEyeOn1 = !_isEyeOn1),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    if (resetState.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      Customebutton(
                        text: "Reset Password",
                        onTap: () async {
                          final pass = _passwordController.text.trim();
                          final confirm = _confirmPasswordController.text.trim();

                          if (pass != confirm) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
                            return;
                          }

                          final ok = await ref.read(resetPasswordProvider.notifier).resetPass(
                                email: widget.email ?? "",
                                token: widget.token ?? "",
                                pass: pass,
                              );

                          if (ok) {
                            if (!context.mounted) return;
                            showDialog(context: context, builder: (context) => const DialogWidget());
                          } else {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(resetState.errorMessage ?? 'Error resetting password')),
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
    );
  }
}