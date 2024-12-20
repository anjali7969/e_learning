import 'package:e_learning/core/app_theme.dart';
import 'package:e_learning/screens/bottom_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Learning',
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(), // Use the custom theme
      home: const BottomNavigationView(),
    );
  }
}
