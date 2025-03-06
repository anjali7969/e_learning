// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_courses_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCourseDTO _$GetAllCourseDTOFromJson(Map<String, dynamic> json) =>
    GetAllCourseDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      courses: (json['courses'] as List<dynamic>)
          .map((e) => CourseApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCourseDTOToJson(GetAllCourseDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'courses': instance.courses.map((e) => e.toJson()).toList(),
    };
