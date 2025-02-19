import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/course_entity.dart';

part 'course_api_model.g.dart';

@JsonSerializable()
class CourseApiModel {
  final String id;
  final String title;
  final String description;
  final String? image; // Nullable image

  CourseApiModel({
    required this.id,
    required this.title,
    required this.description,
    this.image, // ✅ Allow null values
  });

  factory CourseApiModel.fromJson(Map<String, dynamic> json) =>
      _$CourseApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseApiModelToJson(this);

  // ✅ Convert API Model to Domain Entity (Fix `image` null issue)
  CourseEntity toEntity() => CourseEntity(
        id: id,
        title: title,
        description: description,
        image: image ?? "", // ✅ Provide a default empty string if null
      );

  // ✅ Convert List of API Models to List of Entities
  static List<CourseEntity> toEntityList(List<CourseApiModel> courses) {
    return courses.map((course) => course.toEntity()).toList();
  }

  // ✅ Convert Entity to API Model
  static CourseApiModel fromEntity(CourseEntity entity) {
    return CourseApiModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      image: entity.image,
    );
  }
}
