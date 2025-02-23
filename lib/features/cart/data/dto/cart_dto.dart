import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/cart_entity.dart';

part 'cart_dto.g.dart';

@JsonSerializable()
class CartDto {
  final String userId;
  final List<CartItemDto> items;

  CartDto({
    required this.userId,
    required this.items,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartDtoToJson(this);

  // ✅ Convert DTO to Domain Entity
  Cart toEntity() {
    return Cart(
      userId: userId,
      items: items.map((item) => item.toEntity()).toList(),
    );
  }
}

/// **Cart Item DTO**
@JsonSerializable()
class CartItemDto {
  final String courseId;
  final String name;
  final double price;
  final String image;
  final String description;
  final int quantity;

  CartItemDto({
    required this.courseId,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.quantity,
  });

  factory CartItemDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemDtoToJson(this);

  // ✅ Convert DTO to Domain Entity
  CartItem toEntity() {
    return CartItem(
      courseId: courseId,
      name: name,
      price: price,
      image: image,
      description: description,
      quantity: quantity,
    );
  }
}
