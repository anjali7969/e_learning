import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.black,
      toolbarHeight: 60, // Standard AppBar height
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontFamily: 'Montserrat',
      ),
      titleSpacing: 0, // Space for the logo
      actionsIconTheme: IconThemeData(color: Colors.black),
    ),
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[200],
    fontFamily: 'Montserrat',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 14),
        backgroundColor: const Color(0xFF0A3D62),
        foregroundColor: Colors.white,
      ),
    ),
  );
}
