// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartApiModel _$CartApiModelFromJson(Map<String, dynamic> json) => CartApiModel(
      cartId: json['_id'] as String?,
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItemApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartApiModelToJson(CartApiModel instance) =>
    <String, dynamic>{
      '_id': instance.cartId,
      'userId': instance.userId,
      'items': instance.items,
    };

CartItemApiModel _$CartItemApiModelFromJson(Map<String, dynamic> json) =>
    CartItemApiModel(
      courseId: json['courseId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$CartItemApiModelToJson(CartItemApiModel instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'name': instance.name,
      'price': instance.price,
      'image': instance.image,
      'description': instance.description,
      'quantity': instance.quantity,
    };
