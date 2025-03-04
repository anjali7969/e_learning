// import 'package:bloc/bloc.dart';
// import 'package:e_learning/features/bottom_navigation/presentation/view_model/bottom_nav_event.dart';
// import 'package:e_learning/features/bottom_navigation/presentation/view_model/bottom_nav_state.dart';

// class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
//   BottomNavBloc() : super(BottomNavState.initial());

//   @override
//   Stream<BottomNavState> mapEventToState(BottomNavEvent event) async* {
//     if (event is BottomNavItemSelected) {
//       // Update the state with the new selected index
//       yield state.copyWith(selectedIndex: event.index);
//     }
//   }
// }
