import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_api_model.g.dart';

/// **📌 Course API Model for Network Data**
@JsonSerializable()
class CourseApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;

  final String title;
  final String description;
  final String? image; // Nullable image
  final double price;
  final String? videoUrl; // ✅ Added video URL (nullable)

  const CourseApiModel({
    this.id,
    required this.title,
    required this.description,
    this.image, // ✅ Allow null values
    required this.price,
    this.videoUrl, // ✅ Allow null values
  });

  /// ✅ **Empty Constructor (For Defaults)**
  const CourseApiModel.empty()
      : id = '',
        title = '',
        description = '',
        image = '',
        price = 0.0,
        videoUrl = '';

  /// ✅ **Convert JSON to API Model**
  factory CourseApiModel.fromJson(Map<String, dynamic> json) =>
      _$CourseApiModelFromJson(json);

  /// ✅ **Convert API Model to JSON**
  Map<String, dynamic> toJson() => _$CourseApiModelToJson(this);

  /// ✅ **Convert API Model to Domain Entity**
  CourseEntity toEntity() => CourseEntity(
        id: id ?? '',
        title: title,
        description: description,
        image: image ?? '', // Provide a default empty string if null
        price: price,
        videoUrl: videoUrl ?? '', // ✅ Handle null `videoUrl`
      );

  /// ✅ **Convert Entity to API Model**
  factory CourseApiModel.fromEntity(CourseEntity entity) {
    return CourseApiModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      image: entity.image,
      price: entity.price,
      videoUrl: entity.videoUrl,
    );
  }

  /// ✅ **Convert API List to Entity List**
  static List<CourseEntity> toEntityList(List<CourseApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props => [id, title, description, image, price, videoUrl];
}
