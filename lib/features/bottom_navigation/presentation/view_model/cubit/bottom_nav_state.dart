import 'package:equatable/equatable.dart';

class BottomNavigationState extends Equatable {
  final int selectedIndex;

  const BottomNavigationState({required this.selectedIndex});

  BottomNavigationState copyWith({int? selectedIndex}) {
    return BottomNavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [selectedIndex];
}
