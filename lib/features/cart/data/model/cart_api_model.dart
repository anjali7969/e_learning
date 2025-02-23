import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/cart_entity.dart';

part 'cart_api_model.g.dart';

@JsonSerializable()
class CartApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? cartId;
  final String userId;
  final List<CartItemApiModel> items;

  const CartApiModel({
    this.cartId,
    required this.userId,
    required this.items,
  });

  /// JSON Serialization
  factory CartApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartApiModelToJson(this);

  /// Convert from Entity to API Model
  factory CartApiModel.fromEntity(Cart entity) => CartApiModel(
        cartId: entity.userId, // Assuming cartId and userId are the same
        userId: entity.userId,
        items: entity.items
            .map((item) => CartItemApiModel.fromEntity(item))
            .toList(),
      );

  /// Convert API Model to Entity
  Cart toEntity() => Cart(
        userId: userId,
        items: items.map((item) => item.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [cartId, userId, items];
}

/// 🛒 **Cart Item API Model**
@JsonSerializable()
class CartItemApiModel extends Equatable {
  final String courseId;
  final String name;
  final double price;
  final String image;
  final String description;
  final int quantity;

  const CartItemApiModel({
    required this.courseId,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.quantity,
  });

  /// JSON Serialization
  factory CartItemApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemApiModelToJson(this);

  /// Convert from Entity to API Model
  factory CartItemApiModel.fromEntity(CartItem entity) => CartItemApiModel(
        courseId: entity.courseId,
        name: entity.name,
        price: entity.price,
        image: entity.image,
        description: entity.description,
        quantity: entity.quantity,
      );

  /// Convert API Model to Entity
  CartItem toEntity() => CartItem(
        courseId: courseId,
        name: name,
        price: price,
        image: image,
        description: description,
        quantity: quantity,
      );

  @override
  List<Object?> get props =>
      [courseId, name, price, image, description, quantity];
}
