import 'package:e_learning/features/courses/domain/entity/course_entity.dart';

class CourseResponse {
  final bool success;
  final String message;
  final List<CourseEntity> data;
  final int totalCount;
  final int size;
  final int page;

  const CourseResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.totalCount,
    required this.size,
    required this.page,
  });

  /// **✅ Convert JSON to `CourseResponse`**
  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    return CourseResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? 'No message',
      data: (json["data"] as List<dynamic>)
          .map((course) => CourseEntity.fromJson(course))
          .toList(),
      totalCount: json["totalCount"] ?? 0,
      size: json["size"] ?? 0,
      page: json["page"] ?? 0,
    );
  }

  /// **✅ Convert `CourseResponse` to JSON**
  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data.map((course) => course.toJson()).toList(),
      "totalCount": totalCount,
      "size": size,
      "page": page,
    };
  }
}
