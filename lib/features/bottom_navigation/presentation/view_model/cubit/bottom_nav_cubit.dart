import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_view/notice.dart';
import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_view/profile.dart';
import 'package:e_learning/features/bottom_navigation/presentation/view_model/cubit/bottom_nav_state.dart';
import 'package:e_learning/features/courses/presentation/view/courses_view.dart';
import 'package:e_learning/features/home/presentation/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit()
      : super(const BottomNavigationState(selectedIndex: 0));

  final List views = [
    const HomeScreen(),
    const CoursesScreen(),
    const NoticeScreen(),
    const ProfileScreen(),
  ];

  void changeTab(int index) {
    emit(BottomNavigationState(selectedIndex: index));
  }

  Widget get currentView => views[state.selectedIndex];
}
