part of 'bottom_nav_cubit.dart';

class BottomNavigationState extends Equatable {
  final int selectedIndex;
  const BottomNavigationState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
