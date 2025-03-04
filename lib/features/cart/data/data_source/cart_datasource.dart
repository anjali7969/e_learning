// import 'package:dio/dio.dart';
// import 'package:e_learning/app/constants/api_endpoints.dart';
// import 'package:e_learning/app/shared_prefs/user_shared_prefs.dart';
// import 'package:e_learning/features/cart/data/model/cart_item_api_model.dart';
// import 'package:e_learning/features/cart/domain/entity/cart_item_entity.dart';

// class CartDatasource {
//   final Dio _dio;
//   final UserSharedPrefs _userSharedPrefs;

//   CartDatasource({required Dio dio, required UserSharedPrefs userSharedPrefs})
//       : _dio = dio,
//         _userSharedPrefs = userSharedPrefs;

//   /// ✅ **Add Item to Cart**
//   Future<void> addToCart(String userId, CartItemEntity cartItem) async {
//     try {
//       await _dio.post(ApiEndpoints.addToCart, data: {
//         "userId": userId, // ✅ Ensure userId is passed
//         "courseId": cartItem.courseId,
//         "quantity": cartItem.quantity
//       });
//     } on DioException catch (e) {
//       throw Exception(
//           "Failed to add course to cart: ${e.response?.data ?? e.message}");
//     }
//   }

//   /// ✅ **Fetch Cart Items**
//   Future<List<CartItemEntity>> getCart(String userId) async {
//     try {
//       final response = await _dio.get("${ApiEndpoints.getCart}/$userId");

//       if (response.statusCode == 200) {
//         final List<dynamic> cartItems = response.data['cart'];
//         return cartItems
//             .map((e) => CartItemApiModel.fromJson(e as Map<String, dynamic>))
//             .map((e) => e.toEntity()) // ✅ Convert to List<CartItemEntity>
//             .toList();
//       } else {
//         throw Exception("Failed to fetch cart items");
//       }
//     } on DioException catch (e) {
//       throw Exception(
//           "Failed to fetch cart items: ${e.response?.data ?? e.message}");
//     }
//   }

//   /// ✅ **Remove an Item from Cart**
//   Future<void> removeCart(String userId, String courseId) async {
//     try {
//       await _dio.post(ApiEndpoints.removeCartItem, data: {
//         "userId": userId,
//         "courseId": courseId,
//       });
//     } on DioException catch (e) {
//       throw Exception(
//           "Failed to remove item from cart: ${e.response?.data ?? e.message}");
//     }
//   }

//   /// ✅ **Clear Entire Cart**
//   Future<void> clearCart(String userId) async {
//     try {
//       await _dio.post(ApiEndpoints.clearCart, data: {"userId": userId});
//     } on DioException catch (e) {
//       throw Exception("Failed to clear cart: ${e.response?.data ?? e.message}");
//     }
//   }

//   /// ✅ **Update Cart Item Quantity**
//   Future<void> updateCart(String userId, String courseId, int quantity) async {
//     try {
//       await _dio.put("${ApiEndpoints.updateCartItem}/$userId",
//           data: {"courseId": courseId, "quantity": quantity});
//     } on DioException catch (e) {
//       throw Exception(
//           "Failed to update cart: ${e.response?.data ?? e.message}");
//     }
//   }
// }
