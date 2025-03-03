// import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'course_dto.g.dart';

// @JsonSerializable()
// class CourseModel {
//   final String id;
//   final String title;
//   final String description;
//   final String? image;
//   final String? videoUrl;

//   CourseModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     this.image,
//     this.videoUrl,
//   });

//   factory CourseModel.fromJson(Map<String, dynamic> json) =>
//       _$CourseModelFromJson(json);

//   Map<String, dynamic> toJson() => _$CourseModelToJson(this);

//   // ✅ Convert API Model to Domain Entity
//   CourseEntity toEntity() {
//     return CourseEntity(
//       id: id,
//       title: title,
//       description: description,
//       image: image ?? "",
//       videoUrl: videoUrl ?? "",
//     );
//   }
// }
