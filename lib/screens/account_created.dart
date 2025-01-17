// import 'package:e_learning/features/auth/presentation/view/login_view.dart';
// import 'package:flutter/material.dart';

// class AccountCreatedPage extends StatelessWidget {
//   const AccountCreatedPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Gradient background
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFF81D4FA), // Light blue
//                   Color(0xFFFFFFFF), // White
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           // Center content
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 200),

//                   // Logo
//                   Center(
//                     child: Image.asset(
//                       'assets/images/logo.png', // Ensure correct path for the logo
//                       height: 180,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   const Text(
//                     'Account Created Successfully!',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   const Text(
//                     'Your account has been successfully created.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.black,
//                     ),
//                   ),

//                   const SizedBox(height: 40),

//                   // Custom Sign In Button
//                   GestureDetector(
//                     onTap: () {
//                       // Navigate to LoginPage
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const LoginView(),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [
//                             Colors.red,
//                             Colors.orange
//                           ], // Predefined colors
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                         ),
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           'Sign In',
//                           style: TextStyle(
//                             fontFamily: 'Poppins',
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
