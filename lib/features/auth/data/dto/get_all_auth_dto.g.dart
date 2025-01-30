// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthDTO _$AuthDTOFromJson(Map<String, dynamic> json) => AuthDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => AuthApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthDTOToJson(AuthDTO instance) => <String, dynamic>{
      'data': instance.data,
    };
