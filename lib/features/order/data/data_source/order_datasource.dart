// // import 'package:e_learning/features/order/domain/entity/order_entity.dart';

// // /// **Abstract Interface for Order Data Source**
// // abstract interface class IOrderDataSource {
// //   /// **Fetch all orders for the current user**
// //   Future<List<OrderEntity>> getUserOrders();

// //   /// **Confirm a new order**
// //   Future<OrderEntity> confirmOrder(OrderEntity order);

// //   /// **Cancel an order**
// //   Future<void> cancelOrder(String orderId);
// // }

// import 'package:dio/dio.dart';
// import 'package:e_learning/app/constants/api_endpoints.dart';
// import 'package:e_learning/app/shared_prefs/user_shared_prefs.dart';
// import 'package:e_learning/features/order/data/model/order_api_model.dart';
// import 'package:e_learning/features/order/domain/entity/order_entity.dart';

// class OrderDatasource {
//   final Dio _dio;
//   final UserSharedPrefs _userSharedPrefs;

//   OrderDatasource({required Dio dio, required UserSharedPrefs userSharedPrefs})
//       : _dio = dio,
//         _userSharedPrefs = userSharedPrefs;

//   /// ✅ **Confirm Order**
//   Future<OrderEntity> confirmOrder(OrderEntity order) async {
//     try {
//       final response = await _dio.post(ApiEndpoints.orderConfirm, data: {
//         "userId": order.userId, // ✅ Ensure userId is passed
//         "cart": order.cart
//             .map((item) => {
//                   "courseId": item.courseId,
//                   "quantity": item.quantity,
//                   "price": item.price,
//                 })
//             .toList(),
//         "totalAmount": order.totalAmount,
//         "paymentMethod": order.paymentMethod,
//         "phoneNumber": order.phoneNumber,
//       });

//       if (response.statusCode == 201) {
//         final orderData = response.data["order"];
//         return OrderApiModel.fromJson(orderData).toEntity();
//       } else {
//         throw Exception("Failed to confirm order");
//       }
//     } on DioException catch (e) {
//       throw Exception(
//           "Failed to confirm order: ${e.response?.data ?? e.message}");
//     }
//   }

//   /// ✅ **Fetch User Orders**
//   Future<List<OrderEntity>> getUserOrders(String userId) async {
//     try {
//       final response = await _dio.get("${ApiEndpoints.getOrder}/$userId");

//       if (response.statusCode == 200) {
//         final List<dynamic> orders = response.data['orders'];
//         return orders
//             .map((e) => OrderApiModel.fromJson(e as Map<String, dynamic>))
//             .map((e) => e.toEntity())
//             .toList();
//       } else {
//         throw Exception("Failed to fetch user orders");
//       }
//     } on DioException catch (e) {
//       throw Exception(
//           "Failed to fetch user orders: ${e.response?.data ?? e.message}");
//     }
//   }

//   /// ✅ **Cancel an Order**
//   // Future<void> cancelOrder(String orderId) async {
//   //   try {
//   //     await _dio.post(ApiEndpoints.cancelOrder, data: {
//   //       "orderId": orderId,
//   //     });
//   //   } on DioException catch (e) {
//   //     throw Exception("Failed to cancel order: ${e.response?.data ?? e.message}");
//   //   }
//   // }
// }
