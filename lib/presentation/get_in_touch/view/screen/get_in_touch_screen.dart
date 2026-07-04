import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customTextField.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/get_in_touch/view/widget/success_full_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/get_in_touch/viewModel/get_in_touch_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';

class GetInTouchScreen extends ConsumerStatefulWidget {
  const GetInTouchScreen({
    super.key,
    this.planId,
    this.planTitle,
    this.planPrice,
    this.planPeriod,
  });

  final String? planId;
  final String? planTitle;
  final String? planPrice;
  final String? planPeriod;

  @override
  ConsumerState<GetInTouchScreen> createState() => _GetInTouchScreenState();
}

class _GetInTouchScreenState extends ConsumerState<GetInTouchScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final planId = widget.planId?.trim();
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final message = _messageController.text.trim();

    if (planId == null || planId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plan id not found')),
      );
      return;
    }
    if (name.isEmpty || email.isEmpty || phone.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final success = await ref.read(getInTouchProvider.notifier).getIntouch(
          id: planId,
          name: name,
          email: email,
          phone: phone,
          message: message,
        );

    if (!mounted) return;

    if (success) {
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _messageController.clear();
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SuccessfullWidget();
        },
      );
      return;
    }

    final errorMessage = ref.read(getInTouchProvider).errormessage;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage ?? 'Failed to submit')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final getInTouchState = ref.watch(getInTouchProvider);
    final selectedTitle = (widget.planTitle == null || widget.planTitle!.trim().isEmpty)
        ? 'Membership'
        : widget.planTitle!.trim();
    final selectedPrice = (widget.planPrice == null || widget.planPrice!.trim().isEmpty)
        ? null
        : widget.planPrice!.trim();
    final selectedPeriod = (widget.planPeriod == null || widget.planPeriod!.trim().isEmpty)
        ? null
        : widget.planPeriod!.trim();

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(
              text: "Get In Touch",
              ontap: () {
                Navigator.pushReplacementNamed(
                  context,
                  RoutesName.subscriptionScreen,
                );
              },
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorManager.primary, ColorManager.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: ColorManager.whiteColor,
                    border: Border.all(
                      color: ColorManager.borderColor,
                      width: 1.5.w,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: ColorManager.backgroundColorgreen1
                                .withValues(alpha: .2),
                          ),

                          child: Padding(
                            padding: EdgeInsets.all(12.r),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "You’ve selected \"$selectedTitle\" Plan!",
                                        style: getMedium500Style12(
                                          color: ColorManager.drawrColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      IconManager.subtractIcon,
                                      fit: BoxFit.cover,
                                      height: 24.h,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  selectedPrice == null
                                      ? "Please Submit a form with your enquire.Our representative will contach you"
                                      : "Selected Plan ID: ${widget.planId ?? '--'}\nPrice: $selectedPrice${selectedPeriod == null ? '' : '/$selectedPeriod'}\nPlease Submit a form with your enquire.Our representative will contach you",
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Name",
                          style: getMedium500Style12(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          controller: _nameController,
                          hintText: "Your Full Name",
                        ),
                        Text(
                          "Email",
                          style: getMedium500Style12(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          controller: _emailController,
                          hintText: "Email Address",
                        ),
                        Text(
                          "Phone Number",
                          style: getMedium500Style12(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          controller: _phoneController,
                          hintText: "Phone number",
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "What would you like to know more about?",
                          style: getMedium500Style12(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        TextFormField(
                          controller: _messageController,
                          maxLines:
                              6, // This creates the height seen in your image
                          style: getLight300Style12(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                          ),
                          decoration: InputDecoration(
                            hintText: "Your Message here....",
                            hintStyle: getMedium500Style12(
                              color: ColorManager.hintTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            fillColor: ColorManager.whiteColor,
                            filled: true,
                            contentPadding: EdgeInsets.all(16.r),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: BorderSide(
                                color: Colors.grey.withValues(alpha: .2),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: BorderSide(
                                color: ColorManager.backgroundColorgreen,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Customebutton(
                          onTap: getInTouchState.isloading ? null : _submit,
                          text: getInTouchState.isloading ? "Submitting..." : "Submit",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
