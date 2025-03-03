// import 'package:e_learning/features/cart/data/model/cart_item_api_model.dart';
// import 'package:e_learning/features/cart/domain/entity/cart_item_entity.dart';
// import 'package:e_learning/features/order/domain/entity/order_entity.dart';

// /// **Order DTO - Used for Data Transfer**
// class OrderDto {
//   final String orderId;
//   final String userId;
//   final List<CartItemEntity> cart; // ✅ Fixed type
//   final double totalAmount;
//   final String paymentMethod;
//   final String phoneNumber;
//   final String status;

//   OrderDto({
//     required this.orderId,
//     required this.userId,
//     required this.cart,
//     required this.totalAmount,
//     required this.paymentMethod,
//     required this.phoneNumber,
//     required this.status,
//   });

//   /// **Convert JSON to DTO**
//   factory OrderDto.fromJson(Map<String, dynamic> json) {
//     return OrderDto(
//       orderId: json["_id"] ?? "",
//       userId: json["user"] ?? "",
//       cart: (json["cart"] as List)
//           .map((item) =>
//               CartItemApiModel.fromJson(item).toEntity()) // ✅ Fixed parsing
//           .toList(),
//       totalAmount: (json["totalAmount"] as num).toDouble(),
//       paymentMethod: json["paymentMethod"] ?? "",
//       phoneNumber: json["phoneNumber"] ?? "",
//       status: json["status"] ?? "pending",
//     );
//   }

//   /// **Convert DTO to JSON**
//   Map<String, dynamic> toJson() {
//     return {
//       "user": userId,
//       "cart": cart
//           .map((item) => CartItemApiModel.fromEntity(item).toJson())
//           .toList(), // ✅ Convert to DTO before JSON
//       "totalAmount": totalAmount,
//       "paymentMethod": paymentMethod,
//       "phoneNumber": phoneNumber,
//       "status": status,
//     };
//   }

//   /// **Convert DTO to Entity**
//   OrderEntity toEntity() {
//     return OrderEntity(
//       orderId: orderId,
//       userId: userId,
//       cart: cart, // ✅ Directly passing the entity list
//       totalAmount: totalAmount,
//       paymentMethod: paymentMethod,
//       phoneNumber: phoneNumber,
//       status: status,
//     );
//   }

//   /// **Convert Entity to DTO**
//   static OrderDto fromEntity(OrderEntity entity) {
//     return OrderDto(
//       orderId: entity.orderId,
//       userId: entity.userId,
//       cart: entity.cart, // ✅ Directly mapping entity list
//       totalAmount: entity.totalAmount,
//       paymentMethod: entity.paymentMethod,
//       phoneNumber: entity.phoneNumber,
//       status: entity.status,
//     );
//   }
// }
