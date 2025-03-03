// import 'package:e_learning/app/shared_prefs/token_shared_prefs.dart';
// import 'package:e_learning/features/auth/presentation/view/login_view.dart';
// import 'package:e_learning/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:e_learning/features/home/presentation/view/home.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'onboarding_state.dart';

// class OnboardingCubit extends Cubit<void> {
//   final LoginBloc _loginBloc;
//   final TokenSharedPrefs _tokenSharedPrefs;

//   OnboardingCubit(this._loginBloc, this._tokenSharedPrefs) : super(null);

//   /// **✅ Check Token & Navigate to the Correct Screen**
//   Future<void> checkTokenAndNavigate(BuildContext context) async {
//     await Future.delayed(
//         const Duration(seconds: 1)); // Optional delay for smooth transition

//     final tokenResult = await _tokenSharedPrefs.getToken();

//     tokenResult.fold(
//       (failure) {
//         // ❌ If token retrieval fails, go to Login
//         debugPrint("❌ Error fetching token: ${failure.message}");
//         _goToLogin(context);
//       },
//       (String? token) {
//         if (token != null && token.trim().isNotEmpty) {
//           // ✅ Token exists, go to HomePage
//           debugPrint("✅ Token found: Navigating to Home");
//           _goToHome(context);
//         } else {
//           // ❌ No token found, go to Login
//           debugPrint("❌ No token found: Navigating to Login");
//           _goToLogin(context);
//         }
//       },
//     );
//   }

//   /// **📌 Navigate to Login Page**
//   void _goToLogin(BuildContext context) {
//     if (context.mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => BlocProvider.value(
//             value: _loginBloc,
//             child: LoginView(),
//           ),
//         ),
//       );
//     }
//   }

//   /// **📌 Navigate to Home Page**
//   void _goToHome(BuildContext context) {
//     if (context.mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomeScreen(), // ✅ Adjust your Home View
//         ),
//       );
//     }
//   }
// }
