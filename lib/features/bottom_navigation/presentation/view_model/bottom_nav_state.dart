// import 'package:equatable/equatable.dart';

// class BottomNavState extends Equatable {
//   final int selectedIndex;

//   const BottomNavState({required this.selectedIndex});

//   // Initial state with the first index selected (default to Home)
//   factory BottomNavState.initial() {
//     return const BottomNavState(
//         selectedIndex: 0); // Default to the first tab (Home)
//   }

//   @override
//   List<Object> get props => [selectedIndex];

//   // CopyWith method to update state in BLoC
//   BottomNavState copyWith({int? selectedIndex}) {
//     return BottomNavState(
//       selectedIndex: selectedIndex ?? this.selectedIndex,
//     );
//   }
// }
