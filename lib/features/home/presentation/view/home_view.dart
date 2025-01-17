// import 'package:e_learning/core/common/snackbar/my_snackbar.dart';
// import 'package:e_learning/features/home/presentation/view_model/home_cubit.dart';
// import 'package:e_learning/features/home/presentation/view_model/home_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               // Logout code
//               context.read<HomeCubit>().logout();
//               showMySnackBar(
//                 context: context,
//                 message: 'Logging out...',
//                 color: Colors.red,
//               );
//             },
//           ),
//           BlocBuilder<HomeCubit, HomeState>(
//             builder: (context, state) {
//               return Switch(
//                 value: state.isDarkTheme,
//                 onChanged: (value) {
//                   // Change theme through the HomeCubit
//                   context.read<HomeCubit>().toggleTheme(value);
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
//         return state.views.elementAt(state.selectedIndex);
//       }),
//       bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           return BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.dashboard),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.book),
//                 label: 'Learning',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.group),
//                 label: 'Notice',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.account_circle),
//                 label: 'Profile',
//               ),
//             ],
//             currentIndex: state.selectedIndex,
//             selectedItemColor: Colors.white,
//             onTap: (index) {
//               context.read<HomeCubit>().onTabTapped(index);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
