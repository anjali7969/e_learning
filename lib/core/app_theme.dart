import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static getApplicationTheme({required bool isDarkMode}) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: Color(0xFF0A3D62), // Slightly dark blue color
        elevation: 3,
        shadowColor: Colors.black,
        titleTextStyle: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat',
    );
  }
}
