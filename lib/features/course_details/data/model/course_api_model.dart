// import 'package:json_annotation/json_annotation.dart';

// import '../../domain/entity/course_details_entity.dart';

// part 'course_api_model.g.dart';

// @JsonSerializable()
// class CourseDetailsApiModel {
//   final String id;
//   final String title;
//   final String description;
//   final String? image; // ✅ Nullable image
//   final double price; // ✅ Added missing `price` field

//   CourseDetailsApiModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     this.image,
//     required this.price, // ✅ Ensure `price` is required
//   });

//   /// ✅ Convert JSON to API Model
//   factory CourseDetailsApiModel.fromJson(Map<String, dynamic> json) =>
//       _$CourseDetailsApiModelFromJson(json);

//   /// ✅ Convert API Model to JSON
//   Map<String, dynamic> toJson() => _$CourseDetailsApiModelToJson(this);

//   /// ✅ Convert API Model to Domain Entity (Fix `image` null issue)
//   CourseDetailsEntity toEntity() => CourseDetailsEntity(
//         id: id,
//         title: title,
//         description: description,
//         image: image ?? "", // ✅ Default empty string if `null`
//         price: price, // ✅ Ensure price is mapped
//       );

//   /// ✅ Convert List of API Models to List of Entities
//   static List<CourseDetailsEntity> toEntityList(
//       List<CourseDetailsApiModel> courses) {
//     return courses.map((course) => course.toEntity()).toList();
//   }

//   /// ✅ Convert Domain Entity to API Model
//   static CourseDetailsApiModel fromEntity(CourseDetailsEntity entity) {
//     return CourseDetailsApiModel(
//       id: entity.id,
//       title: entity.title,
//       description: entity.description,
//       image: entity.image,
//       price: entity.price, // ✅ Ensure price is mapped
//     );
//   }
// }
