import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/getMe_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/view/screen/all_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/view/screen/completed_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/view/screen/progess_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/view/widet/custome_widget_profile.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/viewModel/profile_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customeAppBarHome/custome_app_bar_home.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final VoidCallback? onOpenDrawer;
  const ProfileScreen({super.key, this.onOpenDrawer});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String? _savedWeight;
  String? _savedWeightUnit;
  String? _savedHeight;
  String? _savedHeightUnit;
  String? _savedDateOfBirth;

  @override
  void initState() {
    super.initState();
    Future.microtask(_loadProfileMeasures);
    Future.microtask((){
      ref.read(profileProvider.notifier).profileData();
    });
  }

  Future<void> _loadProfileMeasures() async {
    final savedWeight = (await SharedPreferenceData.getOnboardingWeight())?.trim();
    final savedWeightUnit =
        (await SharedPreferenceData.getOnboardingWeightUnit())?.trim();
    final savedHeight = (await SharedPreferenceData.getOnboardingHeight())?.trim();
    final savedHeightUnit =
        (await SharedPreferenceData.getOnboardingHeightUnit())?.trim();
    final savedDateOfBirth =
        (await SharedPreferenceData.getOnboardingDateOfBirth())?.trim();

    if (!mounted) return;
    setState(() {
      _savedWeight = savedWeight;
      _savedWeightUnit = savedWeightUnit;
      _savedHeight = savedHeight;
      _savedHeightUnit = savedHeightUnit;
      _savedDateOfBirth = savedDateOfBirth;
    });
  }

  String _formatAge(String? dob) {
    if (dob == null || dob.trim().isEmpty) return '--';
    final date = DateTime.tryParse(dob);
    if (date == null) return '--';

    final now = DateTime.now();
    int age = now.year - date.year;
    final hadBirthday = now.month > date.month ||
        (now.month == date.month && now.day >= date.day);
    if (!hadBirthday) age--;
    if (age < 0) return '--';
    return '$age Year';
  }

  String _formatMeasure(String? value, String unit) {
    final text = value?.trim();
    if (text == null || text.isEmpty) return '--';
    return '$text $unit';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getMeProvider);
    final user = state.me?.data;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: CustomeAppBarHome(
              onProfileTap: widget.onOpenDrawer,
              name: user?.name,
              email: user?.email,
              avatarUrl: user?.avatarUrl ?? user?.avatar,
            ),
          ),
        ),
      ),
      body: DefaultTabController(
      length: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
             Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: ColorManager.whiteColor
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12.w,vertical: 6.h),
              child: Row(
                children: [
                  Expanded(child: CustomeWidgetProfile(
                    title: "Age",
                    value: _formatAge(_savedDateOfBirth ?? user?.dateOfBirth),
                  )),
                  SizedBox(width: 8.w,),
                  Expanded(child: CustomeWidgetProfile(
                    title: "Height",
                    value: _formatMeasure(_savedHeight, _savedHeightUnit ?? "cm"),
                  )),   SizedBox(width: 8.w,),
                  Expanded(child: CustomeWidgetProfile(
                    title: "Weight",
                    value: _formatMeasure(_savedWeight, _savedWeightUnit ?? "Kg"),
                  ))
                ],
              ),
            ),
          ),
          
        ],
      ),
            
            SizedBox(height: 15.h),
      
            Padding(
              padding:  EdgeInsets.only(left: 18.w),
              child: Text("Watch Your History",style: getMedium500Style10(fontSize: 14.sp,color: ColorManager.blackColor,fontWeight: FontWeight.w500),),
            ),
           SizedBox(height: 10.h,),
      Center(
        child: ButtonsTabBar(
          height: 34.h,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
          buttonMargin: EdgeInsets.symmetric(horizontal: 4.w),
          backgroundColor: ColorManager.backgroundColorgreen,
          unselectedBackgroundColor: const Color(0XFFEDEFEB),
          labelStyle: TextStyle(
            color: ColorManager.blackColor,
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
          ),
          unselectedLabelStyle: TextStyle(
            color: const Color(0xFF7A7A7A),
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
          ),
          radius: 100,
          tabs: [
            Tab(text: "All"),
            Tab(text: "Progress"),
            Tab(text: "Completed"),
          ],
        ),
      ),
            SizedBox(height: 8.h),
      
           
            Expanded(
              child: TabBarView(
                children: [
                
                    AllScreen(),
                 ProgessScreen(),
                  CompletedScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
            ));
  }
}
