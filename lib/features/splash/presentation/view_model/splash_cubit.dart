import 'package:dio/dio.dart';
import 'package:e_learning/app/di/di.dart';
import 'package:e_learning/app/shared_prefs/onboarding_shared_prefs.dart';
import 'package:e_learning/app/shared_prefs/token_shared_prefs.dart';
import 'package:e_learning/app/shared_prefs/user_shared_prefs.dart';
import 'package:e_learning/features/auth/presentation/view/login_view.dart';
import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_navigation_view.dart';
import 'package:e_learning/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit(this._tokenSharedPrefs, this._onboardingSharedPrefs,
      this._userSharedPrefs)
      : super(null);

  final TokenSharedPrefs _tokenSharedPrefs;
  final OnboardingSharedPrefs _onboardingSharedPrefs;
  final UserSharedPrefs _userSharedPrefs;

  /// **📌 Initialize Splash Screen & Handle Navigation**
  Future<void> init(BuildContext context) async {
    await Future.delayed(
        const Duration(seconds: 3)); // Short delay for smooth transition
    if (context.mounted) {
      _handleNavigation(context);
    }
  }

  /// **📌 Handle Navigation Based on User Status**
  Future<void> _handleNavigation(BuildContext context) async {
    final tokenResult = await _tokenSharedPrefs.getToken();

    tokenResult.fold(
      (failure) {
        print("⚠️ Token retrieval failed: ${failure.message}");
        _goToOnboarding(context);
      },
      (String? token) async {
        if (token == null || token.trim().isEmpty) {
          print("🚀 No Token Found → Showing Splash & Onboarding");
          _goToOnboarding(context);
        } else {
          print("✅ Token Found → Checking User Data...");
          final userResult = await _userSharedPrefs.getUserId();

          userResult.fold(
            (failure) {
              print("❌ User Data Missing → Redirecting to Onboarding");
              _goToOnboarding(context);
            },
            (userId) {
              if (userId.isEmpty) {
                _goToOnboarding(context);
              } else {
                print("✅ User Verified → Navigating to HomeScreen");
                getIt<Dio>().options.headers['Authorization'] = 'Bearer $token';
                _goToHome(context);
              }
            },
          );
        }
      },
    );
  }

  /// **📌 Check Onboarding Preference**
  Future<void> _checkOnboarding(BuildContext context) async {
    final onboardingResult = await _onboardingSharedPrefs.getFirstTime();

    onboardingResult.fold(
      (failure) => _goToOnboarding(context), // If error, go to Onboarding
      (isFirstTime) {
        if (isFirstTime) {
          _goToOnboarding(context);
        } else {
          _goToLogin(context); // Skip onboarding if already seen
        }
      },
    );
  }

  /// **📌 Navigate to Login Page**
  void _goToLogin(BuildContext context) {
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
      );
    }
  }

  /// **📌 Navigate to Home Page**
  void _goToHome(BuildContext context) {
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationView(),
        ),
      );
    }
  }

  /// **📌 Navigate to Onboarding Page**
  void _goToOnboarding(BuildContext context) {
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingPage(),
        ),
      );
    }
  }

  /// **📌 Logout User & Navigate to Login**
  Future<void> logoutUser(BuildContext context) async {
    await _userSharedPrefs.removeUserData(); // Remove User Data
    await _tokenSharedPrefs.clearToken(); // Remove Token
    print("✅ Token & User Data Cleared. Navigating to Login...");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
      (route) => false,
    );
  }
}
