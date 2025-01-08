import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/app_logo.png', // Replace with your logo path
          height: 30,
          width: 30,
        ),
        const SizedBox(width: 8),
        const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ],
    );
  }
}
