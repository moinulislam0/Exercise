import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/email_otp_verify.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/forget_password/view/forgot_password.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/new_password_screen/view/screen/new_password_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/otp/view/otp_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/signin_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signup/view/signup_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/get_in_touch/view/screen/get_in_touch_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/view/screen/home_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_weight/view/screen.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/view/screen.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/welcome_screen/view/welcome_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/parent_screen/parent_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/playlist/view/screen/playlist_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/prescribed_screen/view/prescibed_details_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/prescribed_screen/view/prescribed_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/setting_screen/view/setting_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/subscription/view/screen/subscription_screen.dart';

import '../../presentation/bottom_nav/view/bottom_nav_bar_screen.dart';
import '../../presentation/splash/view/splash_screen.dart';
import '../resource/constants/strings_manager.dart';
import 'routes_name.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutesName.bottomNavRoute:
        return MaterialPageRoute(builder: (_) => BottomNavBarScreen());
      case RoutesName.onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case RoutesName.onBordingScreenWeight:
        return MaterialPageRoute(builder: (_) => OnBordingScreenWeight());
      case RoutesName.welcomeScreen:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case RoutesName.signInScreen:
        return MaterialPageRoute(builder: (_) => SigninScreen());
      case RoutesName.forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case RoutesName.otpScreen:
        final args = routeSettings.arguments;
        String? email;
        if (args is String) {
          email = args;
        } else if (args is Map) {
          final value = args['email'];
          if (value != null) email = value.toString();
        }
        return MaterialPageRoute(
          builder: (_) => OtpScreen(email: email?.trim()),
        );
      case RoutesName.newPasswordScreen:
        final args = routeSettings.arguments;
        String? email;
        String? token;
        if (args is Map) {
          final e = args['email'];
          final t = args['token'];
          if (e != null) email = e.toString();
          if (t != null) token = t.toString();
        }
        return MaterialPageRoute(
          builder: (_) =>
              NewPasswordScreen(email: email?.trim(), token: token?.trim()),
        );
      case RoutesName.singInUpScreen:
        return MaterialPageRoute(builder: (_) => SingInUpScreen());
      case RoutesName.parentScreen:
        final args = routeSettings.arguments;
        final initialIndex = args is int ? args : 0;
        return MaterialPageRoute(
          builder: (_) => ProviderScope(
            overrides: [
              parentScreenIndexProvider.overrideWith((ref) => initialIndex),
            ],
            child: const ParentScreen(),
          ),
        );
      case RoutesName.favouriteScreen:
        final args = routeSettings.arguments;
        final initialIndex = args is int ? args : 0;
        return MaterialPageRoute(
          builder: (_) => ProviderScope(
            overrides: [
              parentScreenIndexProvider.overrideWith((ref) => initialIndex),
            ],
            child: const ParentScreen(),
          ),
        );
      case RoutesName.prescribedScreen:
        return MaterialPageRoute(builder: (_) => PrescribedScreen());
      case RoutesName.prescibedDetailsScreen:
        final args = routeSettings.arguments;
        String? id;
        String? prescriptionId;
        String? videoUrl;
        int initialPositionMilliseconds = 0;
        if (args is String) {
          id = args;
        } else if (args is Map) {
          final idValue = args['id'];
          final prescriptionIdValue =
              args['prescriptionId'] ??
              args['prescribedId'] ??
              args['prescription_id'];
          final videoValue = args['videoUrl'];
          final initialPositionValue = args['initialPositionMilliseconds'];
          if (idValue != null) id = idValue.toString();
          if (prescriptionIdValue != null) {
            prescriptionId = prescriptionIdValue.toString();
          }
          if (videoValue != null) videoUrl = videoValue.toString();
          if (initialPositionValue is int) {
            initialPositionMilliseconds = initialPositionValue;
          } else if (initialPositionValue != null) {
            initialPositionMilliseconds =
                int.tryParse(initialPositionValue.toString()) ?? 0;
          }
        }
        return MaterialPageRoute(
          builder: (_) => PrescibedDetailsScreen(
            id: id,
            prescriptionId: prescriptionId,
            videoUrl: videoUrl,
            initialPositionMilliseconds: initialPositionMilliseconds,
          ),
        );
      case RoutesName.settingScreen:
        return MaterialPageRoute(builder: (_) => SettingScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RoutesName.subscriptionScreen:
        return MaterialPageRoute(builder: (_) => SubscriptionScreen());
      case RoutesName.getInTouchScreen:
        final args = routeSettings.arguments;
        String? planId;
        String? planTitle;
        String? planPrice;
        String? planPeriod;
        if (args is Map) {
          final idValue = args['id'];
          final titleValue = args['title'];
          final priceValue = args['price'];
          final periodValue = args['period'];
          if (idValue != null) planId = idValue.toString();
          if (titleValue != null) planTitle = titleValue.toString();
          if (priceValue != null) planPrice = priceValue.toString();
          if (periodValue != null) planPeriod = periodValue.toString();
        }
        return MaterialPageRoute(
          builder: (_) => GetInTouchScreen(
            planId: planId,
            planTitle: planTitle,
            planPrice: planPrice,
            planPeriod: planPeriod,
          ),
        );
      case RoutesName.playlistScreen:
        return MaterialPageRoute(builder: (_) => PlaylistScreen());
      case RoutesName.emailOtpVerify:
        final args = routeSettings.arguments;
        String? email;
        if (args is String) {
          email = args;
        } else if (args is Map) {
          final value = args['email'];
          if (value != null) email = value.toString();
        }
        if (email == null || email.trim().isEmpty) {
          return unDefineRoute();
        }
        return MaterialPageRoute(
          builder: (_) => EmailOtpVerify(email: email!.trim()),
        );

      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(StringManager.noRoute)),
        body: Center(child: Text(StringManager.noRoute)),
      ),
    );
  }
}
