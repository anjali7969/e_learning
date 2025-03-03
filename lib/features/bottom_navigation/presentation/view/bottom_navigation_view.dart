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
import 'package:e_learning/features/bottom_navigation/presentation/view_model/cubit/bottom_nav_cubit.dart';
import 'package:e_learning/features/courses/presentation/view/courses_view.dart';
import 'package:e_learning/features/courses/presentation/view_model/cubit/course_cubit.dart';
import 'package:e_learning/features/home/presentation/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationView extends StatelessWidget {
  BottomNavigationView({super.key});

  final List<Widget> bottomScreens = [
    const HomeScreen(),
    const CoursesScreen(),
    // const OrderScreen,
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<BottomNavigationCubit>()),
        BlocProvider(create: (context) => getIt<CoursesCubit>()..loadCourses()),
        // BlocProvider(create: (context) => getIt<CartCubit>()..getCart()),
        // BlocProvider(create: (context) => getIt<ProfileCubit>()..getProfile()),
      ],
      child: BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
          final int selectedIndex =
              context.watch<BottomNavigationCubit>().state.selectedIndex;

          return Scaffold(
            // appBar: AppBar(
            //   title: const Text('E-Learning'),
            //   centerTitle: true,
            //   backgroundColor: Colors.blue.shade700,
            //   actions: [
            //     IconButton(
            //       icon: const Icon(Icons.logout),
            //       onPressed: () async {
            //         getIt<Dio>().options.headers.remove('Authorization');
            //         getIt<TokenSharedPrefs>().clearToken();

            //         Navigator.pushReplacement(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const LoginView()),
            //         );
            //       },
            //     ),
            //   ],
            // ),
            body: IndexedStack(
              index: selectedIndex,
              children: bottomScreens,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school), // ✅ Added Courses Icon
                  label: 'Courses',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              backgroundColor: Colors.white,
              selectedItemColor: Colors.blue.shade700,
              unselectedItemColor: Colors.grey,
              currentIndex: selectedIndex,
              onTap: context.read<BottomNavigationCubit>().changeIndex,
            ),
          );
        },
      ),
    );
  }
}
