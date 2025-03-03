// import 'package:dio/dio.dart';
// import 'package:e_learning/features/course_details/data/model/course_api_model.dart';
// import 'package:e_learning/features/course_details/domain/entity/course_details_entity.dart';

// import '../../../../../app/constants/api_endpoints.dart';

// class CourseDetailsRemoteDataSource {
//   final Dio _dio;

//   CourseDetailsRemoteDataSource(this._dio);

//   Future<CourseDetailsEntity> getCourseById(String courseId) async {
//     try {
//       var response = await _dio.get('${ApiEndpoints.getCourseById}/$courseId');
//       if (response.statusCode == 200) {
//         return CourseDetailsApiModel.fromJson(response.data).toEntity();
//       } else {
//         throw Exception(response.statusMessage);
//       }
//     } on DioException catch (e) {
//       throw Exception(e.message);
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
// }
