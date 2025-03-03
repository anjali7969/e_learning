// import 'package:dartz/dartz.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:e_learning/features/courses/data/data_source/remote_datasource/course_remote_datasource.dart';
// import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
// import 'package:e_learning/features/courses/domain/repository/course_repository.dart';

// /// **📌 Course Remote Repository Implementation**
// class CourseRemoteRepository implements ICourseRepository {
//   final CourseRemoteDatasource _courseRemoteDataSource;

//   CourseRemoteRepository({
//     required CourseRemoteDatasource courseRemoteDataSource,
//   }) : _courseRemoteDataSource = courseRemoteDataSource;

//   /// **✅ Get All Courses**
//   @override
//   Future<Either<Failure, List<CourseEntity>>> getAllCourses() async {
//     try {
//       final courses = await _courseRemoteDataSource.getAllCourses();

//       // ✅ Check if the response is empty
//       if (courses.isEmpty) {
//         return const Left(ApiFailure(
//           "No courses found",
//           message: "No courses available at the moment.",
//           statusCode: 404,
//         ));
//       }

//       return Right(courses);
//     } catch (e) {
//       return Left(ApiFailure(
//         "Error fetching all courses",
//         message: e.toString(),
//       ));
//     }
//   }

//   /// **✅ Get Course by ID**
//   @override
//   Future<Either<Failure, CourseEntity>> getCourseById(String courseId) async {
//     try {
//       final course = await _courseRemoteDataSource.getCourseById(courseId);

//       return Right(course);
//     } catch (e) {
//       return Left(ApiFailure(
//         "Error fetching course by ID",
//         message: e.toString(),
//       ));
//     }
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/courses/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
import 'package:e_learning/features/courses/domain/repository/course_repository.dart';

class CourseRepositoryImpl implements ICourseRepository {
  final CourseRemoteDatasource remoteDataSource;

  CourseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() async {
    try {
      final courses = await remoteDataSource.getAllCourses();
      return Right(courses);
    } catch (e) {
      return Left(ApiFailure(
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, CourseEntity>> getCourseById(String courseId) {
    // TODO: implement getCourseById
    throw UnimplementedError();
  }
}
