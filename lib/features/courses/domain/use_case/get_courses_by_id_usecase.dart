// import 'package:dartz/dartz.dart';
// import 'package:e_learning/app/usecase/usecase.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
// import 'package:e_learning/features/courses/domain/repository/course_repository.dart';
// import 'package:equatable/equatable.dart';

// /// **📌 Parameters for Fetching Course by ID**
// class GetCourseByIdParams extends Equatable {
//   final String courseId;

//   const GetCourseByIdParams({required this.courseId});

//   @override
//   List<Object?> get props => [courseId];
// }

// /// **📌 Get Course by ID Use Case**
// class GetCourseByIdUseCase
//     implements UsecaseWithParams<CourseEntity, GetCourseByIdParams> {
//   final ICourseRepository courseRepository;

//   GetCourseByIdUseCase({required this.courseRepository});

//   @override
//   Future<Either<Failure, CourseEntity>> call(GetCourseByIdParams params) async {
//     return courseRepository.getCourseById(params.courseId);
//   }
// }
