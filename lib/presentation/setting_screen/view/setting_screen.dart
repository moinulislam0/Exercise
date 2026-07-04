import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/network/api_endpoints.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/core/service/notification_service.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/getMe_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/provider/file_image_picker_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/setting_screen/view/widget/height_setting_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/setting_screen/viewModel/delete_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/setting_screen/viewModel/setting_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/setting_screen/view/widget/setting_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/setting_screen/view/widget/successfully_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/setting_screen/view/widget/weight_setting_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';



class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String? _remoteAvatarUrl;
  bool _didInitialize = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(_loadProfileData);
  }

  Future<void> _loadProfileData() async {
    final currentState = ref.read(getMeProvider);
    if (currentState.me == null && !currentState.isLoading) {
      await ref.read(getMeProvider.notifier).getMe();
    }

    final meState = ref.read(getMeProvider);
    final user = meState.me?.data;

    final savedWeight = (await SharedPreferenceData.getOnboardingWeight())?.trim();
    final savedWeightUnit = (await SharedPreferenceData.getOnboardingWeightUnit())?.trim().toLowerCase();
    final savedHeight = (await SharedPreferenceData.getOnboardingHeight())?.trim();
    final savedHeightUnit = (await SharedPreferenceData.getOnboardingHeightUnit())?.trim().toLowerCase();
    final savedGender = (await SharedPreferenceData.getOnboardingGender())?.trim().toLowerCase();

    if (!mounted) return;

    _userNameController.text = user?.name?.trim() ?? '';
    _emailController.text = user?.email?.trim() ?? '';
    _dateOfBirthController.text = _formatDateForDisplay(user?.dateOfBirth);
    _weightController.text = savedWeight ?? '';
    _heightController.text = savedHeight ?? '';
    _remoteAvatarUrl = user?.avatarUrl?.trim() ?? user?.avatar?.trim();

    final genderValue = (user?.gender?.trim().toLowerCase().isNotEmpty == true)
        ? user!.gender!.trim().toLowerCase()
        : savedGender ?? '';
    ref.read(genderIndexProvider.notifier).state = _mapGenderIndex(genderValue);
    ref.read(weightStateProvider.notifier).state = savedWeightUnit == 'lb' ? 1 : 0;
    ref.read(heightUnitProvider.notifier).state = savedHeightUnit == 'cm' ? 1 : 0;

    setState(() {
      _didInitialize = true;
    });
  }

  int _mapGenderIndex(String gender) {
    switch (gender) {
      case 'female': return 1;
      case 'other': return 2;
      default: return 0;
    }
  }

  String _genderFromIndex(int index) {
    switch (index) {
      case 1: return 'female';
      case 2: return 'other';
      default: return 'male';
    }
  }

  String _formatDateForDisplay(String? value) {
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) return '';

    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;

    final day = parsed.day.toString().padLeft(2, '0');
    final month = parsed.month.toString().padLeft(2, '0');
    final year = parsed.year.toString().padLeft(4, '0');
    return '$day/$month/$year';
  }

  String _formatDateForApi(String value) {
    final raw = value.trim();
    if (raw.isEmpty) return '';

    final parts = raw.split('/');
    if (parts.length == 3) {
      final day = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);
      if (day != null && month != null && year != null) {
        final parsed = DateTime.utc(year, month, day);
        return parsed.toIso8601String();
      }
    }

    final parsed = DateTime.tryParse(raw);
    return parsed?.toUtc().toIso8601String() ?? raw;
  }

  String? _resolveAvatarUrl(String? avatar) {
    final value = avatar?.trim();
    if (value == null || value.isEmpty) return null;
    if (value.startsWith('http://') || value.startsWith('https://')) return value;
    final base = ApiEndpoints.baseUrl.endsWith('/')
        ? ApiEndpoints.baseUrl.substring(0, ApiEndpoints.baseUrl.length - 1)
        : ApiEndpoints.baseUrl;
    final path = value.startsWith('/') ? value : '/$value';
    return '$base$path';
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final deleteState = ref.watch(deleteProvider);
            
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
              elevation: 0,
              backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(color: Color(0xFFF04438), shape: BoxShape.circle),
                      child: Center(
                        child: Icon(Icons.priority_high, color: Colors.white, size: 30.sp),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Delete Account?",
                      style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: const Color(0xFF101828)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Are you sure you want to permanently delete your account? This action cannot be undone.",
                      style: TextStyle(fontSize: 14.sp, color: const Color(0xFF667085), height: 1.4),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),
                    if (deleteState.isloading)
                      const CircularProgressIndicator(color: Color(0xFFF04438))
                    else
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                await NotificationService.clearTokenOnLogout();
                                await SharedPreferenceData.removeToken();
                                final success = await ref.read(deleteProvider.notifier).deleteProfile();
                                if (success) {
                                  if (!context.mounted) return;
                                  Navigator.pop(context); 
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RoutesName.signInScreen, 
                                    (route) => false,
                                  );
                                } else {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(deleteState.errormessage ?? "Delete failed")),
                                  );
                                }
                              },
                              child: Container(
                                height: 38.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF04438),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Center(
                                  child: Text("Delete", style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                height: 38.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: const Color(0xFFD0D5DD), width: 1.w),
                                ),
                                child: Center(
                                  child: Text("Cancel", style: TextStyle(color: const Color(0xFF344054), fontSize: 16.sp, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _dateOfBirthController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heightUnitIndex = ref.watch(heightUnitProvider);
    final weightUnitIndex = ref.watch(weightStateProvider);
    final pickerState = ref.watch(fileImagePickerProvider);
    final getMeState = ref.watch(getMeProvider);
    final settingState = ref.watch(settingProvider);

    final heightUnitText = heightUnitIndex == 0 ? "feet" : "cm";
    final weightUnitText = weightUnitIndex == 0 ? "Kg" : "Lb";
    final resolvedAvatarUrl = _resolveAvatarUrl(_remoteAvatarUrl);

    if (!_didInitialize && !getMeState.isLoading) {
      Future.microtask(_loadProfileData);
    }

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(
              text: "Settings",
              ontap: () {
                Navigator.pushReplacementNamed(context, RoutesName.parentScreen);
              },
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorManager.primary, ColorManager.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: getMeState.isLoading && !_didInitialize
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  children: [
                    Container(
                      width: 343.w,
                      decoration: BoxDecoration(
                        color: ColorManager.playlistBox,
                        border: Border.all(color: ColorManager.borderColor, width: 1.5.w),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 40.w),
                                Text("Your Info", style: getMedium500Style10(color: ColorManager.textPrimary, fontSize: 18.sp)),
                                IconButton(
                                  onPressed: () => _showDeleteDialog(context),
                                  icon: Icon(Icons.delete_outline, color: Colors.grey, size: 24.sp),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Center(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(999),
                                onTap: () => ref.read(fileImagePickerProvider.notifier).pickSingleImage(),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 96.w,
                                      height: 96.w,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F3F0),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: ColorManager.borderColor, width: 1.2.w),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: pickerState.singleImage != null
                                          ? Image.file(File(pickerState.singleImage!.path), fit: BoxFit.cover)
                                          : resolvedAvatarUrl != null
                                              ? Image.network(
                                                  resolvedAvatarUrl,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) => Image.asset(ImageManager.profilePic, fit: BoxFit.cover),
                                                )
                                              : Image.asset(ImageManager.profilePic, fit: BoxFit.cover),
                                    ),
                                    Positioned(
                                      right: -2.w,
                                      bottom: -2.h,
                                      child: Container(
                                        width: 30.w,
                                        height: 30.w,
                                        decoration: BoxDecoration(
                                          color: ColorManager.backgroundColorgreen,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: ColorManager.whiteColor, width: 2.w),
                                        ),
                                        child: Center(child: Image.asset(IconManager.camera, width: 14.w, height: 14.w)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text("UserName", style: getMedium500Style10(color: ColorManager.textPrimary, fontSize: 16.sp)),
                            TextField(
                              controller: _userNameController,
                              decoration: InputDecoration(
                                hintText: 'enter your username',
                                suffixIcon: Padding(padding: EdgeInsets.all(11.r), child: Image.asset(IconManager.edit, height: 12.h, width: 12.w)),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorManager.hintTextColor)),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text("Email", style: getMedium500Style10(color: ColorManager.textPrimary, fontSize: 16.sp)),
                            TextField(
                              controller: _emailController,
                              readOnly: true,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'enter your email',
                                suffixIcon: Padding(padding: EdgeInsets.all(11.r), child: Image.asset(IconManager.edit, height: 12.h, width: 12.w)),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorManager.hintTextColor)),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text("Date of Birth", style: getMedium500Style10(color: ColorManager.textPrimary, fontSize: 16.sp)),
                            TextField(
                              controller: _dateOfBirthController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                hintText: 'dd/mm/yyyy',
                                suffixIcon: Padding(padding: EdgeInsets.all(11.r), child: Image.asset(IconManager.edit, height: 12.h, width: 12.w)),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorManager.hintTextColor)),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text("Gender", style: getMedium500Style10(color: ColorManager.textPrimary, fontSize: 16.sp)),
                            SizedBox(height: 8.h),
                            const SettingWidgetGender(),
                            SizedBox(height: 20.h),
                            Text("Weight", style: getMedium500Style10(color: ColorManager.textPrimary, fontSize: 16.sp)),
                            SizedBox(height: 8.h),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), border: Border.all(color: ColorManager.borderColor)),
                              child: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: Column(
                                  children: [
                                    const WeightSettingWidget(),
                                    SizedBox(height: 12.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            IntrinsicWidth(
                                              child: TextField(
                                                controller: _weightController,
                                                keyboardType: TextInputType.number,
                                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w500),
                                                decoration: InputDecoration(hintText: '25',hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none, isDense: true),
                                              ),
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(weightUnitText, style: TextStyle(fontSize: 16.sp, color: Colors.grey, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        Image.asset(IconManager.edit, height: 18.h, width: 18.w),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Text("Height", style: getMedium500Style10(color: ColorManager.textPrimary, fontSize: 16.sp)),
                            SizedBox(height: 8.h),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), border: Border.all(color: ColorManager.borderColor)),
                              child: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: Column(
                                  children: [
                                    const HeightSettingWidget(),
                                    SizedBox(height: 12.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            IntrinsicWidth(
                                              child: TextField(
                                                controller: _heightController,
                                                keyboardType: TextInputType.number,
                                                style: TextStyle(fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w500),
                                                decoration: const InputDecoration(hintText: '52',hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none, isDense: true),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(heightUnitText, style: TextStyle(fontSize: 14.sp, color: Colors.grey, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        Image.asset(IconManager.edit, height: 18.h, width: 18.w),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    if (settingState.isloading)
                      const Center(child: CircularProgressIndicator())
                    else
                      Customebutton(
                        onTap: () async {
                          final name = _userNameController.text.trim();
                          final email = _emailController.text.trim();
                          final dateOfBirth = _formatDateForApi(
                            _dateOfBirthController.text,
                          );
                          final weight = _weightController.text.trim();
                          final height = _heightController.text.trim();
                          final parsedWeight = num.tryParse(weight);
                          final parsedHeight = num.tryParse(height);
                          final gender = _genderFromIndex(ref.read(genderIndexProvider));
                          final imageFile = pickerState.singleImage != null ? File(pickerState.singleImage!.path) : null;

                          if (name.isEmpty || email.isEmpty || weight.isEmpty || height.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All fields are required')));
                            return;
                          }

                          final ok = await ref.read(settingProvider.notifier).updateUser(
                            name: name, email: email, dateOfBirth: dateOfBirth, weight: parsedWeight!, height: parsedHeight!, gender: gender, image: imageFile,
                          );

                          if (ok) {
                            await SharedPreferenceData.setOnboardingWeight(weight);
                            await SharedPreferenceData.setOnboardingHeight(height);
                            await SharedPreferenceData.setOnboardingGender(gender);
                            await SharedPreferenceData.setOnboardingWeightUnit(weightUnitText);
                            await SharedPreferenceData.setOnboardingHeightUnit(heightUnitText);
                            await ref.read(getMeProvider.notifier).getMe();
                            if (!context.mounted) return;
                            showDialog(context: context, builder: (context) => const SuccessfullyWidget());
                          } else {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(settingState.errormessage ?? 'Update failed')));
                          }
                        },
                        text: "Save",
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
