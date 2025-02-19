import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
import 'package:e_learning/features/courses/domain/repository/course_repository.dart';

class GetCourses {
  final CourseRepository repository;

  GetCourses(this.repository);

  Future<Either<Failure, List<CourseEntity>>> call() async {
    return await repository.getCourses();
  }
}
