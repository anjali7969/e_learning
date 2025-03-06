// import 'package:e_learning/features/auth/presentation/view/register_view.dart';
// import 'package:flutter/material.dart';

// class OnboardingPage3 extends StatelessWidget {
//   const OnboardingPage3({super.key});

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
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Image
//                 Image.asset(
//                   'assets/images/onboarding6.png',
//                   height: 300,
//                 ),
//                 const SizedBox(height: 20),

//                 // Title
//                 const Text(
//                   'Unlock Your Learning Potential',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 10),

//                 // Subtitle
//                 const Text(
//                   'Your Gateway To Personalized Courses,\nAnd Guidance For Success.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 40),

//                 // Get Started Button (Navigates to Bottom Navigation)
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
//                       // Navigate directly to the Bottom Navigation Page
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const RegisterView(),
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
//                     child: const Text(
//                       'GET STARTED',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
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
