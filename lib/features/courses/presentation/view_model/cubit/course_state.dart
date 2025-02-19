import 'package:e_learning/features/courses/domain/entity/course_entity.dart';

abstract class CourseState {}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final List<CourseEntity> courses;
  CourseLoaded(this.courses);
}

class CourseError extends CourseState {
  final String message;
  CourseError(this.message);
}
