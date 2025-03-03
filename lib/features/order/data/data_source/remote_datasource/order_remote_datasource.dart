// import 'package:dio/dio.dart';
// import 'package:e_learning/app/constants/api_endpoints.dart';
// import 'package:e_learning/app/shared_prefs/token_shared_prefs.dart';
// import 'package:e_learning/features/cart/data/dto/cart_dto.dart'; // ✅ Use DTO instead of Entity
// import 'package:e_learning/features/order/domain/entity/order_entity.dart';

// abstract class IOrderRemoteDataSource {
//   Future<OrderEntity> confirmOrder(OrderEntity order);
//   Future<List<OrderEntity>> getUserOrders(String userId);
// }

// class OrderRemoteDataSource implements IOrderRemoteDataSource {
//   final Dio _dio;
//   final TokenSharedPrefs _tokenPrefs;

//   OrderRemoteDataSource(this._dio, this._tokenPrefs);

//   /// **✅ Confirm Order**
//   @override
//   Future<OrderEntity> confirmOrder(OrderEntity order) async {
//     try {
//       final tokenEither = await _tokenPrefs.getToken();
//       final token = tokenEither.fold(
//           (failure) => throw Exception("Failed to retrieve token"), (t) => t);

//       // ✅ Convert Domain Entity to DTO for API request
//       final orderData = {
//         "cart": order.cart
//             .map((item) => CartItemDto.fromEntity(item).toJson())
//             .toList(),
//         "totalAmount": order.totalAmount,
//         "paymentMethod": order.paymentMethod,
//         "phoneNumber": order.phoneNumber,
//       };

//       final response = await _dio.post(
//         ApiEndpoints.orderConfirm,
//         data: orderData,
//         options: Options(
//           headers: {"Authorization": "Bearer $token"},
//         ),
//       );

//       // ✅ Validate Response
//       if (response.statusCode == 201) {
//         final orderData = response.data["order"];

//         return OrderEntity(
//           orderId: orderData["_id"],
//           userId: orderData["user"],
//           cart: (orderData["cart"] as List)
//               .map((item) => CartItemDto.fromJson(item)
//                   .toEntity()) // ✅ Convert DTO to Entity
//               .toList(),
//           totalAmount: orderData["totalAmount"].toDouble(),
//           paymentMethod: orderData["paymentMethod"],
//           phoneNumber: orderData["phoneNumber"],
//           status: orderData["status"],
//         );
//       } else {
//         throw Exception("Failed to confirm order");
//       }
//     } catch (e) {
//       throw Exception("API Error: ${e.toString()}");
//     }
//   }

//   /// **✅ Get Orders for a User**
//   @override
//   Future<List<OrderEntity>> getUserOrders(String userId) async {
//     try {
//       final tokenEither = await _tokenPrefs.getToken();
//       final token = tokenEither.fold(
//           (failure) => throw Exception("Failed to retrieve token"), (t) => t);

//       final response = await _dio.get(
//         ApiEndpoints.getOrder,
//         options: Options(
//           headers: {"Authorization": "Bearer $token"},
//         ),
//       );

//       // ✅ Validate Response
//       if (response.statusCode == 200) {
//         return (response.data as List)
//             .map((order) => OrderEntity(
//                   orderId: order["_id"],
//                   userId: order["user"],
//                   cart: (order["cart"] as List)
//                       .map((item) => CartItemDto.fromJson(item)
//                           .toEntity()) // ✅ Convert DTO to Entity
//                       .toList(),
//                   totalAmount: order["totalAmount"].toDouble(),
//                   paymentMethod: order["paymentMethod"],
//                   phoneNumber: order["phoneNumber"],
//                   status: order["status"],
//                 ))
//             .toList();
//       } else {
//         throw Exception("Failed to fetch orders");
//       }
//     } catch (e) {
//       throw Exception("API Error: ${e.toString()}");
//     }
//   }
// }
