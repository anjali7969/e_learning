// import 'package:e_learning/features/cart/data/model/cart_item_api_model.dart';
// import 'package:e_learning/features/order/domain/entity/order_entity.dart';

// /// **Order API Model - Handles API Communication**
// class OrderApiModel {
//   final String orderId;
//   final String userId;
//   final List<CartItemApiModel>
//       cart; // ✅ FIX: Use API Model for proper conversion
//   final double totalAmount;
//   final String paymentMethod;
//   final String phoneNumber;
//   final String status;

//   OrderApiModel({
//     required this.orderId,
//     required this.userId,
//     required this.cart,
//     required this.totalAmount,
//     required this.paymentMethod,
//     required this.phoneNumber,
//     required this.status,
//   });

//   /// **✅ Convert API JSON to Model**
//   factory OrderApiModel.fromJson(Map<String, dynamic> json) {
//     return OrderApiModel(
//       orderId: json["_id"] ?? "",
//       userId: json["user"] ?? "",
//       cart: (json["cart"] as List)
//           .map((item) => CartItemApiModel.fromJson(item)) // ✅ Corrected Parsing
//           .toList(),
//       totalAmount: (json["totalAmount"] as num).toDouble(),
//       paymentMethod: json["paymentMethod"] ?? "",
//       phoneNumber: json["phoneNumber"] ?? "",
//       status: json["status"] ?? "pending",
//     );
//   }

//   /// **✅ Convert Model to JSON**
//   Map<String, dynamic> toJson() {
//     return {
//       "user": userId,
//       "cart": cart
//           .map((item) => item.toJson()) // ✅ Uses `CartItemApiModel.toJson()`
//           .toList(),
//       "totalAmount": totalAmount,
//       "paymentMethod": paymentMethod,
//       "phoneNumber": phoneNumber,
//       "status": status,
//     };
//   }

//   /// **✅ Convert API Model to Entity**
//   OrderEntity toEntity() {
//     return OrderEntity(
//       orderId: orderId,
//       userId: userId,
//       cart: cart
//           .map((item) => item.toEntity()) // ✅ Convert API Model to Entity
//           .toList(),
//       totalAmount: totalAmount,
//       paymentMethod: paymentMethod,
//       phoneNumber: phoneNumber,
//       status: status,
//     );
//   }

//   /// **✅ Convert Entity to API Model**
//   static OrderApiModel fromEntity(OrderEntity entity) {
//     return OrderApiModel(
//       orderId: entity.orderId,
//       userId: entity.userId,
//       cart: entity.cart
//           .map((item) => CartItemApiModel.fromEntity(
//               item)) // ✅ Convert Entity to API Model
//           .toList(),
//       totalAmount: entity.totalAmount,
//       paymentMethod: entity.paymentMethod,
//       phoneNumber: entity.phoneNumber,
//       status: entity.status,
//     );
//   }
// }
