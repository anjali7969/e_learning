// import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_view/home.dart';
// import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_view/learning.dart';
// import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_view/notice.dart';
// import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_view/profile.dart';
// import 'package:flutter/material.dart';

// class BottomNavigationView extends StatefulWidget {
//   const BottomNavigationView({super.key});

//   @override
//   _BottomNavigationViewState createState() => _BottomNavigationViewState();
// }

// class _BottomNavigationViewState extends State<BottomNavigationView> {
//   // The current index for the selected screen
//   int _selectedIndex = 0;

//   // List of screens to be displayed
//   final List<Widget> _screens = const [
//     HomeScreen(),
//     LearningScreen(),
//     NoticeScreen(),
//     ProfileScreen(),
//   ];

//   // Function to handle item tap on the bottom navigation bar
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selectedIndex], // Display the selected screen
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex, // Set the selected index
//         onTap: _onItemTapped, // Call the function when an item is tapped
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
//       ),
//     );
//   }
// }

import 'package:e_learning/app/di/di.dart';
import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_view/profile.dart';
import 'package:e_learning/features/cart/presentation/view/cart_view.dart';
import 'package:e_learning/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:e_learning/features/courses/presentation/view/courses_view.dart';
import 'package:e_learning/features/home/presentation/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({super.key});

  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CoursesScreen(),
    const ShoppingCartScreen(userId: "USER_ID_HERE"),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CartCubit>()..fetchCart("USER_ID_HERE"),
        ),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white, // ✅ White background
          selectedItemColor: Colors.blue.shade700, // ✅ Blue active icon
          unselectedItemColor: Colors.grey, // ✅ Gray inactive icons
          type: BottomNavigationBarType.fixed, // ✅ Ensures proper spacing
          elevation: 5, // ✅ Adds a slight shadow effect
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: "Courses"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
