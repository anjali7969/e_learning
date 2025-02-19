import 'package:e_learning/features/courses/domain/entity/course_entity.dart';

abstract interface class ICourseDataSource {
  Future<List<CourseEntity>> getAllCourses();
}
