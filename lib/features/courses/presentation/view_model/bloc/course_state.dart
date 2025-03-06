// part of 'course_bloc.dart';

// /// **📌 Course State Class**
// class CourseState extends Equatable {
//   final List<CourseEntity> courses;
//   final CourseEntity? selectedCourse;
//   final bool isLoading;
//   final String? error;

//   const CourseState({
//     required this.courses,
//     this.selectedCourse,
//     required this.isLoading,
//     this.error,
//   });

//   /// **📌 Initial State**
//   factory CourseState.initial() {
//     return const CourseState(
//       courses: [],
//       selectedCourse: null,
//       isLoading: false,
//       error: null,
//     );
//   }

//   /// **📌 Copy With Method for State Updates**
//   CourseState copyWith({
//     List<CourseEntity>? courses,
//     CourseEntity? selectedCourse,
//     bool? isLoading,
//     String? error,
//   }) {
//     return CourseState(
//       courses: courses ?? this.courses,
//       selectedCourse: selectedCourse ?? this.selectedCourse,
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//     );
//   }

//   @override
//   List<Object?> get props => [courses, selectedCourse, isLoading, error];
// }
