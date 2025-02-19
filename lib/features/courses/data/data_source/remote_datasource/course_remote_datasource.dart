import 'package:dio/dio.dart';
import 'package:e_learning/app/constants/api_endpoints.dart';
import 'package:e_learning/features/courses/data/dto/course_dto.dart';
import 'package:e_learning/features/courses/domain/entity/course_entity.dart';

abstract class ICourseRemoteDataSource {
  Future<List<CourseEntity>> getAllCourses();
}

class CourseRemoteDataSource implements ICourseRemoteDataSource {
  final Dio _dio;

  CourseRemoteDataSource(this._dio);

  @override
  Future<List<CourseEntity>> getAllCourses() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllCourses);

      if (response.statusCode == 200) {
        List<CourseModel> courseModels = (response.data as List)
            .map((json) => CourseModel.fromJson(json))
            .toList();

        return courseModels.map((model) => model.toEntity()).toList();
      } else {
        throw Exception("Failed to load courses");
      }
    } on DioException catch (e) {
      throw Exception("API error: ${e.message}");
    }
  }
}
