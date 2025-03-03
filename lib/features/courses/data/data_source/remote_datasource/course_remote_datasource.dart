import 'package:dio/dio.dart';
import 'package:e_learning/features/courses/data/model/course_api_model.dart';
import 'package:e_learning/features/courses/domain/entity/course_entity.dart';

import '../../../../../app/constants/api_endpoints.dart';

class CourseRemoteDatasource {
  final Dio _dio;

  CourseRemoteDatasource(this._dio);

  // Future<void> createProduct(ProductEntity product) async {
  //   try {
  //     // Convert entity to model
  //     var productApiModel = ProductApiModel.fromEntity(product);
  //     var response = await _dio.post(
  //       ApiEndpoints.createProduct,
  //       data: productApiModel.toJson(),
  //     );
  //     if (response.statusCode == 201) {
  //       return;
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e.message);
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  Future<List<CourseEntity>> getAllCourses() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllCourses);
      if (response.statusCode == 200) {
        var data = response.data as List<dynamic>;
        return data
            .map((course) => CourseApiModel.fromJson(course).toEntity())
            .toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CourseEntity> getCourseById(String courseId) async {
    try {
      var response = await _dio.get('${ApiEndpoints.getCourseById}/$courseId');
      if (response.statusCode == 200) {
        return CourseApiModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Future<void> updateProduct(ProductEntity productEntity) async {
  //   try {
  //     var productApiModel = ProductApiModel.fromEntity(productEntity);
  //     var response = await _dio.put(
  //       '${ApiEndpoints.updateProduct}/${productEntity.id}',
  //       data: productApiModel.toJson(),
  //     );
  //     if (response.statusCode == 200) {
  //       return;
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e.message);
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  // Future<void> deleteProduct(String id, String? token) async {
  //   try {
  //     var response = await _dio.delete('${ApiEndpoints.deleteProduct}/$id');
  //     if (response.statusCode == 200) {
  //       return;
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e.message);
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
}
