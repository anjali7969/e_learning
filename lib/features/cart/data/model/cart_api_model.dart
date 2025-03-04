// import 'package:e_learning/features/cart/data/model/cart_item_api_model.dart';
// import 'package:e_learning/features/cart/domain/entity/cart_entity.dart';
// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'cart_api_model.g.dart';

// @JsonSerializable()
// class CartApiModel extends Equatable {
//   final String userId;
//   final List<CartItemApiModel> items; // ✅ Fixed: Uses CartItemApiModel

//   const CartApiModel({required this.userId, required this.items});

//   /// ✅ Convert JSON to `CartApiModel`
//   factory CartApiModel.fromJson(Map<String, dynamic> json) =>
//       _$CartApiModelFromJson(json);

//   /// ✅ Convert `CartApiModel` to JSON
//   Map<String, dynamic> toJson() => _$CartApiModelToJson(this);

//   /// ✅ Convert API Model to Domain Entity
//   CartEntity toEntity() => CartEntity(
//         userId: userId,
//         items: items.map((e) => e.toEntity()).toList(),
//       );

//   /// ✅ Convert Domain Entity to API Model
//   static CartApiModel fromEntity(CartEntity entity) => CartApiModel(
//         userId: entity.userId,
//         items: entity.items.map((e) => CartItemApiModel.fromEntity(e)).toList(),
//       );

//   @override
//   List<Object?> get props => [userId, items];
// }
