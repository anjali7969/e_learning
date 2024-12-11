import 'package:e_learning/screens/auth/splash_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      home: SplashScreen(),
      // Set the initial route
      // initialRoute: '/',
      // // Define the route mapping
      // routes: {
      //   '/': (context) => const StudentDetailsView(), // Default route
      //   '/output': (context) => const StudentOutputView(),
      // },
    );
  }
}
