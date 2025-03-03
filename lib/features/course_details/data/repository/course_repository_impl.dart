// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:e_learning/app/constants/api_endpoints.dart';
// import 'package:e_learning/core/error/failure.dart';

// import '../../domain/entity/course_details_entity.dart';
// import '../../domain/repository/course_repository.dart';

// class CourseRepositoryImpl implements CourseRepository {
//   final Dio dio;

//   CourseRepositoryImpl(this.dio);

//   @override
//   Future<Either<Failure, CourseDetailsEntity>> getCourseById(
//       String courseId) async {
//     try {
//       final String url = "${ApiEndpoints.baseUrl}${ApiEndpoints.getCourseById}"
//           .replaceAll(":courseId", courseId);

//       final response = await dio.get(url); // ✅ No need for `Uri.parse(url)`

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonData =
//             response.data; // ✅ Dio auto-parses JSON

//         if (jsonData.isEmpty) {
//           return const Left(ApiFailure(
//             "Course not found",
//             message: "Course not found",
//             statusCode: 404,
//           ));
//         }

//         final course = CourseDetailsEntity.fromJson(jsonData);
//         return Right(course); // ✅ Returning a single `CourseDetailsEntity`
//       } else if (response.statusCode == 404) {
//         return const Left(ApiFailure(
//           "Course not found",
//           message: "Course not found",
//           statusCode: 404,
//         ));
//       } else {
//         return Left(ApiFailure(
//           "Failed to fetch course details",
//           message: "Failed to fetch course details",
//           statusCode: response.statusCode ?? 500, // ✅ Default status code
//         ));
//       }
//     } catch (e) {
//       return Left(ApiFailure(
//         "Unexpected error",
//         message: "Unexpected error: ${e.toString()}",
//         statusCode: 500, // ✅ Internal server error
//       ));
//     }
//   }
// }
