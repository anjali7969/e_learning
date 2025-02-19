import 'package:e_learning/features/courses/data/model/course_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_courses_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class GetAllCourseDTO {
  final bool success;
  final int count;
  final List<CourseApiModel>
      courses; // Renamed from `data` to `courses` for clarity

  GetAllCourseDTO({
    required this.success,
    required this.count,
    required this.courses,
  });

  factory GetAllCourseDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllCourseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCourseDTOToJson(this);
}
