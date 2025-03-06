import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit()
      : super(const BottomNavigationState(selectedIndex: 0));

  void changeIndex(int index) =>
      emit(BottomNavigationState(selectedIndex: index));
}
