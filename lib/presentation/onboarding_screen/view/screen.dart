import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_birthday/view/onboarding_screen_birthday.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_brings/view/onboarding_screen_brigns.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_gender/view/onboarding_screen_gender.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_height/view/onboarding_screen_height.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_weight/view/screen.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_weight/view/widget/custome_appBar.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int totalPages = 5;

  Future<bool> _validateAndPersistCurrentStep() async {
    switch (_currentPage) {
      case 0:
        await SharedPreferenceData.setOnboardingWeightUnit(
          ref.read(weightUnitProvider),
        );
        final weight = (await SharedPreferenceData.getOnboardingWeight())?.trim();
        if (weight == null || weight.isEmpty) {
          _showSnack('Please enter your weight.');
          return false;
        }
        return true;

      case 1:
        await SharedPreferenceData.setOnboardingHeightUnit(
          ref.read(heightUnitProvider),
        );
        final height = (await SharedPreferenceData.getOnboardingHeight())?.trim();
        if (height == null || height.isEmpty) {
          _showSnack('Please enter your height.');
          return false;
        }
        return true;

      case 2:
        final dob =
            (await SharedPreferenceData.getOnboardingDateOfBirth())?.trim();
        if (dob == null || dob.isEmpty) {
          _showSnack('Please enter your date of birth.');
          return false;
        }
        try {
          DateTime.parse(dob);
        } catch (_) {
          _showSnack('Please enter a valid date of birth.');
          return false;
        }
        return true;

      case 3:
        final isMale = ref.read(selectItem);
        await SharedPreferenceData.setOnboardingGender(isMale ? 'male' : 'female');
        return true;

      case 4:
        final selected = ref.read(selectItemsProvider);
        await SharedPreferenceData.setOnboardingPersonalization(selected);
        if (selected.isEmpty) {
          _showSnack('Please select at least one option.');
          return false;
        }
        return true;
    }
    return true;
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: CustomeAppbar(
        onBackTap: () {
          FocusScope.of(context).unfocus();
          if (_currentPage > 0) {
            _pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        onSkipTap: () async {
          FocusScope.of(context).unfocus();
          await SharedPreferenceData.setOnboardingCompleted(true);
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, RoutesName.singInUpScreen);
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: List.generate(totalPages, (index) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: index == _currentPage 
                            ? Color(0xFF98D14F) 
                            : Colors.grey.withValues(alpha: 0.2), 
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Page View
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                   OnBordingScreenWeight(),
                  OnboardingScreenHeight(),
                  OnboardingScreenBirthday(),
                  OnboardingScreenGender(),
                  OnboardingScreenBrigns(),
                ],
              ),
            ),

            // Continue Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    final ok = await _validateAndPersistCurrentStep();
                    if (!ok) return;
                    if (_currentPage < totalPages - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                    else{
                      await SharedPreferenceData.setOnboardingCompleted(true);
                      Navigator.pushReplacementNamed(context,RoutesName.welcomeScreen);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF98D14F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Image.asset(IconManager.arrowRight,height: 16.h,width: 16.w,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
