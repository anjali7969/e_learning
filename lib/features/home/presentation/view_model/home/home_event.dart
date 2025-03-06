import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// 🔄 Fetch Courses Event
class FetchCoursesEvent extends HomeEvent {}
