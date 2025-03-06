import 'package:equatable/equatable.dart';
import 'package:e_learning/features/courses/domain/entity/course_entity.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

// 🔄 Initial State
class HomeInitial extends HomeState {}

// 🔄 Loading State
class HomeLoading extends HomeState {}

// ✅ Courses Loaded Successfully
class HomeLoaded extends HomeState {
  final List<CourseEntity> courses;
  HomeLoaded(this.courses);

  @override
  List<Object> get props => [courses];
}

// ❌ Error State
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);

  @override
  List<Object> get props => [message];
}
