import 'package:e_learning/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().init(context); // Initialize navigation logic
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF81D4FA), // Light blue
                  Color(0xFFFFFFFF), // White
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Center content (Logo and Progress Indicator)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo in the center
                Image.asset(
                  'assets/images/logo.png',
                  height: screenHeight * 0.5, // Adjust size to your preference
                  width: screenWidth * 0.7, // Adjust width as needed
                ),
                const SizedBox(height: 35), // Space between logo and loader

                // CircularProgressIndicator near the bottom of the screen
                const CircularProgressIndicator(),
                const SizedBox(height: 10),

                // Version text under the progress indicator
                const Text('Version: 1.0.0'),
              ],
            ),
          ),

          // Developer signature at the bottom
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 4,
            child: const Text(
              'Developed by: Anjali Shrestha',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
