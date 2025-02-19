import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/courses/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
import 'package:e_learning/features/courses/domain/repository/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource remoteDataSource;

  CourseRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses() async {
    try {
      final result = await remoteDataSource.getAllCourses();
      return Right(result);
    } catch (e) {
      return Left(ApiFailure(message: e.toString())); // ✅ Corrected
    }
  }
}
