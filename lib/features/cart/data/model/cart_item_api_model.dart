// import 'package:e_learning/features/cart/domain/entity/cart_item_entity.dart';
// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'cart_item_api_model.g.dart';

// @JsonSerializable()
// class CartItemApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String courseId; // ✅ Fixed: Matches backend schema
//   final String name;
//   final String image;
//   final String description;
//   final int quantity;
//   final double price;

//   const CartItemApiModel({
//     required this.courseId,
//     required this.name,
//     required this.image,
//     required this.description,
//     required this.quantity,
//     required this.price,
//   });

//   /// ✅ Convert JSON to Model
//   factory CartItemApiModel.fromJson(Map<String, dynamic> json) =>
//       _$CartItemApiModelFromJson(json);

//   /// ✅ Convert Model to JSON
//   Map<String, dynamic> toJson() => _$CartItemApiModelToJson(this);

//   /// ✅ Convert API model to Entity
//   CartItemEntity toEntity() => CartItemEntity(
//         courseId: courseId,
//         name: name,
//         image: image,
//         description: description,
//         quantity: quantity,
//         price: price,
//       );

//   /// ✅ Convert Entity to API model
//   static CartItemApiModel fromEntity(CartItemEntity entity) => CartItemApiModel(
//         courseId: entity.courseId,
//         name: entity.name,
//         image: entity.image,
//         description: entity.description,
//         quantity: entity.quantity,
//         price: entity.price,
//       );

//   @override
//   List<Object?> get props =>
//       [courseId, name, image, description, quantity, price];
// }
