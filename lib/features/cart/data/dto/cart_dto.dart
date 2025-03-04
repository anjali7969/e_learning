// import 'package:e_learning/features/cart/domain/entity/cart_item_entity.dart';
// import 'package:json_annotation/json_annotation.dart';

// import '../../domain/entity/cart_entity.dart';

// part 'cart_dto.g.dart';

// @JsonSerializable()
// class CartDto {
//   final String userId;
//   final List<CartItemDto> items;

//   CartDto({
//     required this.userId,
//     required this.items,
//   });

//   /// **✅ Convert JSON to DTO**
//   factory CartDto.fromJson(Map<String, dynamic> json) =>
//       _$CartDtoFromJson(json);

//   /// **✅ Convert DTO to JSON**
//   Map<String, dynamic> toJson() => _$CartDtoToJson(this);

//   /// **✅ Convert DTO to Domain Entity**
//   CartEntity toEntity() {
//     return CartEntity(
//       userId: userId,
//       items: items.map((item) => item.toEntity()).toList(),
//     );
//   }

//   /// **✅ Convert Domain Entity to DTO**
//   static CartDto fromEntity(CartEntity entity) {
//     return CartDto(
//       userId: entity.userId,
//       items: entity.items.map((item) => CartItemDto.fromEntity(item)).toList(),
//     );
//   }
// }

// /// **Cart Item DTO**
// @JsonSerializable()
// class CartItemDto {
//   final String courseId;
//   final String name;
//   final double price;
//   final String image;
//   final String description;
//   final int quantity;

//   CartItemDto({
//     required this.courseId,
//     required this.name,
//     required this.price,
//     required this.image,
//     required this.description,
//     required this.quantity,
//   });

//   /// **✅ Convert JSON to DTO**
//   factory CartItemDto.fromJson(Map<String, dynamic> json) =>
//       _$CartItemDtoFromJson(json);

//   /// **✅ Convert DTO to JSON**
//   Map<String, dynamic> toJson() => _$CartItemDtoToJson(this);

//   /// **✅ Convert DTO to Domain Entity**
//   CartItemEntity toEntity() {
//     return CartItemEntity(
//       courseId: courseId,
//       name: name,
//       price: price,
//       image: image,
//       description: description,
//       quantity: quantity,
//     );
//   }

//   /// **✅ Convert Domain Entity to DTO**
//   static CartItemDto fromEntity(CartItemEntity entity) {
//     return CartItemDto(
//       courseId: entity.courseId,
//       name: entity.name,
//       price: entity.price,
//       image: entity.image,
//       description: entity.description,
//       quantity: entity.quantity,
//     );
//   }
// }
