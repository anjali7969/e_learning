part of 'course_cubit.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object> get props => [];
}

class CoursesLoading extends CoursesState {
  const CoursesLoading();
}

class CoursesLoaded extends CoursesState {
  final List<CourseEntity> courses;

  const CoursesLoaded({required this.courses});

  @override
  List<Object> get props => [courses];
}

class CoursesError extends CoursesState {
  final String message;

  const CoursesError(this.message);

  @override
  List<Object> get props => [message];
}

/// **📌 New State for Navigation**
class NavigateToCourseDetails extends CoursesState {
  final CourseEntity course;

  const NavigateToCourseDetails(this.course);

  @override
  List<Object> get props => [course];
}
