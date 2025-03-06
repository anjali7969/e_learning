// import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
// import 'package:equatable/equatable.dart';

// /// **📌 Abstract Class for Course Details State Management**
// abstract class SingleCourseState extends Equatable {
//   const SingleCourseState();

//   @override
//   List<Object?> get props => [];
// }

// /// **📌 Initial State**
// class SingleCourseInitial extends SingleCourseState {}

// /// **📌 Loading State**
// class SingleCourseLoading extends SingleCourseState {}

// /// **📌 Loaded State**
// class SingleCourseLoaded extends SingleCourseState {
//   final CourseEntity course;

//   const SingleCourseLoaded({required this.course});

//   @override
//   List<Object?> get props => [course];
// }

// /// **📌 Error State**
// class SingleCourseError extends SingleCourseState {
//   final String message;

//   const SingleCourseError(this.message);

//   @override
//   List<Object?> get props => [message];
// }
