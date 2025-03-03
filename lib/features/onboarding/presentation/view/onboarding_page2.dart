// import 'package:e_learning/features/onboarding/presentation/view/onboarding_page3.dart';
// import 'package:flutter/material.dart';

// import '../widgets/dot_indicator.dart';

// class OnboardingPage2 extends StatelessWidget {
//   const OnboardingPage2({super.key});

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
//         child: Center(
//           // Center all child widgets
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // Adjust height to content
//               crossAxisAlignment:
//                   CrossAxisAlignment.center, // Center horizontally
//               children: [
//                 Image.asset(
//                   'assets/images/onboarding5.png', // Replace with your image path
//                   height: 300,
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Embark on Your Learning Adventure',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.center, // Ensure proper text alignment
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'Explore Interactive Lessons, Quizzes, And Multimedia Content To Enhance Your Understanding.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     DotIndicator(),
//                     DotIndicator(isActive: true),
//                     DotIndicator(),
//                   ],
//                 ),
//                 const SizedBox(height: 40),
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     gradient: const LinearGradient(
//                       colors: [
//                         Color(0xFF3498DB),
//                         Color.fromARGB(255, 37, 75, 101)
//                       ],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const OnboardingPage3(),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.transparent,
//                       foregroundColor: Colors.white,
//                       elevation: 0, // Remove default elevation
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 25,
//                       ),
//                     ),
//                     child: const Text('CONTINUE'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
