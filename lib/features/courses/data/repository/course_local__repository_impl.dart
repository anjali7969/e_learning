// import 'package:dartz/dartz.dart';
// import 'package:e_learning/features/courses/data/data_source/local_datasource/course_local_datasource%20copy.dart';
// import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
// import 'package:e_learning/features/courses/domain/repository/course_repository.dart';

// import '../../../../core/error/failure.dart';

// /// **📌 Course Local Repository**
// class CourseLocalRepository implements ICourseRepository {
//   final CourseLocalDatasource _courseLocalDataSource;

//   CourseLocalRepository({
//     required CourseLocalDatasource courseLocalDataSource,
//   }) : _courseLocalDataSource = courseLocalDataSource;

//   /// **✅ Get Course by ID**
//   @override
//   Future<Either<Failure, CourseEntity>> getCourseById(String courseId) async {
//     try {
//       final courseHiveModel =
//           await _courseLocalDataSource.getCourseById(courseId);

//       // ✅ **Fix: Check if courseHiveModel is null**
//       if (courseHiveModel == null) {
//         return const Left(LocalDatabaseFailure(message: 'Course not found'));
//       }

//       // ✅ Convert to Entity & Return
//       final course = courseHiveModel.toEntity();
//       return Right(course);
//     } catch (e) {
//       return Left(
//           LocalDatabaseFailure(message: 'Error fetching course by ID: $e'));
//     }
//   }

//   /// **✅ Get All Courses**
//   @override
//   Future<Either<Failure, List<CourseEntity>>> getAllCourses() async {
//     try {
//       final courses = await _courseLocalDataSource.getAllCourses();
//       return Right(courses);
//     } catch (e) {
//       return Left(
//           LocalDatabaseFailure(message: 'Error fetching all courses: $e'));
//     }
//   }
// }
