// import 'package:e_learning/features/onboarding/presentation/view/onboarding_page2.dart';
// import 'package:flutter/material.dart';

// import '../widgets/dot_indicator.dart'; // Import the DotIndicator widget

// class OnboardingPage1 extends StatelessWidget {
//   const OnboardingPage1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF81D4FA), // Light blue
//               Color(0xFFFFFFFF), // White
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/onboarding4.png', // Replace with your image path
//                 height: 300,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Enter the World of E-Learning',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Begin Your Educational Journey With\nAccess To A Diverse Range Of Courses.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   DotIndicator(isActive: true),
//                   DotIndicator(),
//                   DotIndicator(),
//                 ],
//               ),
//               const SizedBox(height: 40),
//               // Centered Continue Button
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color(0xFF3498DB),
//                       Color.fromARGB(255, 37, 75, 101)
//                     ],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const OnboardingPage2(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     foregroundColor: Colors.white,
//                     elevation: 0, // Remove default elevation
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 10,
//                       horizontal: 25,
//                     ),
//                   ),
//                   child: const Text('CONTINUE'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
