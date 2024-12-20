import 'package:e_learning/screens/homepage.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),

      home: const HomePage(),
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
