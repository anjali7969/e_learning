import 'package:dartz/dartz.dart';
import 'package:e_learning/features/courses/data/model/course_api_model.dart';
import 'package:e_learning/features/courses/data/repository/course_remote_repository.dart';
import 'package:e_learning/features/courses/domain/entity/course_entity.dart';

import '../../../../app/usecase/usecase.dart';
import '../../../../core/error/failure.dart';

class GetCoursesUsecase
    implements UsecaseWithParams<List<CourseEntity>, CourseApiModel> {
  final CourseRepositoryImpl repository;

  GetCoursesUsecase(this.repository);

  @override
  Future<Either<Failure, List<CourseEntity>>> call(
      CourseApiModel params) async {
    try {
      final result = await repository.getAllCourses();

      return result.fold(
        (failure) => Left(failure),
        (courses) => Right(courses),
      );
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
