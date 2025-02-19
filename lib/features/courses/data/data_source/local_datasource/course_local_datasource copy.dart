import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ICourseLocalDataSource {
  Future<void> cacheCourses(List<CourseEntity> courses);
  Future<List<CourseEntity>> getCachedCourses();
  Future<void> clearCachedCourses();
}

class CourseLocalDataSource implements ICourseLocalDataSource {
  static const String _boxName = "coursesBox";

  @override
  Future<void> cacheCourses(List<CourseEntity> courses) async {
    var box = await Hive.openBox<CourseEntity>(_boxName);
    await box.clear(); // Clear old data
    for (var course in courses) {
      await box.put(course.id, course);
    }
  }

  @override
  Future<List<CourseEntity>> getCachedCourses() async {
    var box = await Hive.openBox<CourseEntity>(_boxName);
    return box.values.toList();
  }

  @override
  Future<void> clearCachedCourses() async {
    var box = await Hive.openBox<CourseEntity>(_boxName);
    await box.clear();
  }
}
