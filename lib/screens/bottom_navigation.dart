// import 'package:e_learning/screens/BottomScreen/home.dart';
// import 'package:e_learning/screens/BottomScreen/learning.dart';
// import 'package:e_learning/screens/BottomScreen/notice.dart';
// import 'package:e_learning/screens/BottomScreen/profile.dart';
// import 'package:flutter/material.dart';

// class BottomNavigationView extends StatefulWidget {
//   const BottomNavigationView({super.key});

//   @override
//   State<BottomNavigationView> createState() => BottomNavigationViewState();
// }

// class BottomNavigationViewState extends State<BottomNavigationView> {
//   int selectedIndex = 0;

//   final List<Widget> lstBottomScreen = [
//     const HomeScreen(),
//     const LearningScreen(),
//     const NoticeScreen(),
//     const ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: lstBottomScreen[selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             label: 'Learning',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notice',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: selectedIndex,
//         onTap: (index) {
//           setState(() {
//             selectedIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
