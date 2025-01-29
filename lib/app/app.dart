import 'package:e_learning/app/di/di.dart'; // Only keep e_learning imports
import 'package:e_learning/core/app_theme.dart';
import 'package:e_learning/features/splash/presentation/view/splash_screen_view.dart'; // Correct path to SplashScreen
import 'package:e_learning/features/splash/presentation/view_model/splash_cubit.dart'; // Correct path to SplashCubit
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Learning',
      theme: AppTheme.getApplicationTheme(isDarkMode: false),
      home: BlocProvider.value(
        value: getIt<
            SplashCubit>(), // Ensure SplashCubit is properly provided by getIt
        child:
            const SplashScreen(), // SplashScreen widget is being used from the correct package
      ),
    );
  }
}
