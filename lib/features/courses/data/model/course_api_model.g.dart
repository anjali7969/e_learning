// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseApiModel _$CourseApiModelFromJson(Map<String, dynamic> json) =>
    CourseApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String?,
      price: (json['price'] as num).toDouble(),
      videoUrl: json['videoUrl'] as String?,
    );

Map<String, dynamic> _$CourseApiModelToJson(CourseApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'videoUrl': instance.videoUrl,
    };
