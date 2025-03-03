import 'package:dio/dio.dart';
import 'package:e_learning/app/constants/api_endpoints.dart';
import 'package:e_learning/features/courses/data/model/course_api_model.dart';
import 'package:e_learning/features/courses/data/model/course_response.dart';

abstract class CoursesRemoteDatasource {
  Future<CourseResponse> getAllCourses(CourseApiModel request);
}

class CoursesRemoteDatasourceImpl implements CoursesRemoteDatasource {
  final Dio dio;

  const CoursesRemoteDatasourceImpl(this.dio);

  @override
  Future<CourseResponse> getAllCourses(CourseApiModel request) async {
    try {
      final response = await dio.get(ApiEndpoints.getAllCourses,
          queryParameters: request.toJson());
      if (response.statusCode == 200) {
        return CourseResponse.fromJson(response.data);
      }
      throw Exception('Failed to load courses');
    } catch (e) {
      throw Exception(e);
    }
  }
}
