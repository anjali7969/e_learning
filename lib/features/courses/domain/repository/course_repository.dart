import 'package:dartz/dartz.dart';
import 'package:e_learning/features/courses/domain/entity/course_entity.dart';

import '../../../../core/error/failure.dart';

abstract interface class ICourseRepository {
  // Future<Either<Failure, void>> createProduct(ProductEntity productEntity);

  Future<Either<Failure, List<CourseEntity>>> getAllCourses();

  // Future<Either<Failure, CourseEntity>> getCourseById(String courseId);

  // Future<Either<Failure, void>> updateProduct(
  //     ProductEntity productEntity, String? token);

  // Future<Either<Failure, void>> deleteProduct(String id, String? token);
}
