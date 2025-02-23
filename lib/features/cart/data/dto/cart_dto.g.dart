// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDto _$CartDtoFromJson(Map<String, dynamic> json) => CartDto(
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartDtoToJson(CartDto instance) => <String, dynamic>{
      'userId': instance.userId,
      'items': instance.items,
    };

CartItemDto _$CartItemDtoFromJson(Map<String, dynamic> json) => CartItemDto(
      courseId: json['courseId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$CartItemDtoToJson(CartItemDto instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'name': instance.name,
      'price': instance.price,
      'image': instance.image,
      'description': instance.description,
      'quantity': instance.quantity,
    };
