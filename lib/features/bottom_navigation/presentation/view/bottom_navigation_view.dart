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

import 'package:e_learning/features/bottom_navigation/presentation/view_model/cubit/bottom_nav_cubit.dart';
import 'package:e_learning/features/bottom_navigation/presentation/view_model/cubit/bottom_nav_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationCubit(),
      child: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
          final cubit = context.read<BottomNavigationCubit>();

          return Scaffold(
            body: cubit.currentView, // Get the current view dynamically
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.selectedIndex,
              onTap: (index) => cubit.changeTab(index),
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.school), label: 'Courses'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications), label: 'Notice'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          );
        },
      ),
    );
  }
}
