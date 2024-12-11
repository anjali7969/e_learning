import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color
      body: Stack(
        children: [
          // Logo at the top
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/logo.png', // Path to your logo
                height: 210.0, // Adjust the size of the logo
              ),
            ),
          ),
          // Circular button at bottom-right
          Positioned(
            bottom: 55,
            right: 40,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, '/loginPage'); // Navigate to login page
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Static circular outline
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey, // Outline color
                        width: 3, // Thickness of the border
                      ),
                    ),
                  ),
                  // Inner button with shadow
                  Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: Colors.blue, // Button color
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_forward, // Arrow icon
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// this is a page 