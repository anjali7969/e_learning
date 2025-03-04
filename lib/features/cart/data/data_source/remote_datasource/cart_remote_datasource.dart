// import 'package:dio/dio.dart';
// import 'package:e_learning/app/constants/api_endpoints.dart';
// import 'package:e_learning/app/shared_prefs/token_shared_prefs.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:e_learning/features/cart/data/dto/cart_dto.dart';
// import 'package:e_learning/features/cart/domain/entity/cart_entity.dart';
// import 'package:e_learning/features/cart/domain/entity/cart_item_entity.dart';

// /// **Cart Remote Data Source Interface**
// abstract class ICartRemoteDataSource {
//   Future<CartEntity> getCart(String userId);
//   Future<void> addToCart(String userId, CartItemEntity item);
//   Future<void> updateCartItem(String userId, String courseId, int quantity);
//   Future<void> removeCartItem(String userId, String courseId);
//   Future<void> clearCart(String userId);
// }

// /// **Cart Remote Data Source Implementation**
// class CartRemoteDataSource implements ICartRemoteDataSource {
//   final Dio _dio;
//   final TokenSharedPrefs _tokenSharedPrefs;

//   CartRemoteDataSource(this._dio, this._tokenSharedPrefs);

//   /// ✅ **Helper Function to Get Token Securely**
//   Future<String> _getAuthToken() async {
//     final tokenResult = await _tokenSharedPrefs.getToken();
//     return tokenResult.fold(
//       (failure) =>
//           throw ApiFailure(message: "❌ Token Error: ${failure.message}"),
//       (token) {
//         if (token.isEmpty) throw const ApiFailure(message: "❌ No Token Found!");
//         return token;
//       },
//     );
//   }

//   /// ✅ **Get User Cart**
//   @override
//   Future<CartEntity> getCart(String userId) async {
//     try {
//       final token = await _getAuthToken();
//       final url = "${ApiEndpoints.getCart}/$userId";

//       final response = await _dio.get(
//         url,
//         options: Options(headers: _buildHeaders(token)),
//       );

//       if (response.statusCode == 200) {
//         return CartDto.fromJson(response.data).toEntity();
//       }
//       throw ApiFailure(
//           message: "❌ Failed to load cart: ${response.statusMessage}");
//     } on DioException catch (e) {
//       throw ApiFailure(message: "❌ API Error: ${_handleDioError(e)}");
//     } catch (e) {
//       throw ApiFailure(message: "❌ Unexpected Error: $e");
//     }
//   }

//   /// ✅ **Add Item to Cart**
//   @override
//   Future<void> addToCart(String userId, CartItemEntity item) async {
//     try {
//       final token = await _getAuthToken();

//       final response = await _dio.post(
//         ApiEndpoints.addToCart,
//         data: {
//           "userId": userId,
//           "courseId": item.courseId,
//           "quantity": item.quantity,
//         },
//         options: Options(headers: _buildHeaders(token)),
//       );

//       if (response.statusCode != 201) {
//         throw const ApiFailure(message: "❌ Failed to add item to cart");
//       }
//     } on DioException catch (e) {
//       throw ApiFailure(message: "❌ API Error: ${_handleDioError(e)}");
//     } catch (e) {
//       throw ApiFailure(message: "❌ Unexpected Error: $e");
//     }
//   }

//   /// ✅ **Update Cart Item**
//   @override
//   Future<void> updateCartItem(
//       String userId, String courseId, int quantity) async {
//     try {
//       final token = await _getAuthToken();
//       final url = "${ApiEndpoints.updateCartItem}/$userId/update";

//       final response = await _dio.put(
//         url,
//         data: {"courseId": courseId, "quantity": quantity},
//         options: Options(headers: _buildHeaders(token)),
//       );

//       if (response.statusCode != 200) {
//         throw const ApiFailure(message: "❌ Failed to update cart item");
//       }
//     } on DioException catch (e) {
//       throw ApiFailure(message: "❌ API Error: ${_handleDioError(e)}");
//     } catch (e) {
//       throw ApiFailure(message: "❌ Unexpected Error: $e");
//     }
//   }

//   /// ✅ **Remove Item from Cart**
//   @override
//   Future<void> removeCartItem(String userId, String courseId) async {
//     try {
//       final token = await _getAuthToken();
//       final url = "${ApiEndpoints.removeCartItem}/$courseId";

//       final response = await _dio.delete(
//         url,
//         data: {"userId": userId},
//         options: Options(headers: _buildHeaders(token)),
//       );

//       if (response.statusCode != 200) {
//         throw const ApiFailure(message: "❌ Failed to remove item from cart");
//       }
//     } on DioException catch (e) {
//       throw ApiFailure(message: "❌ API Error: ${_handleDioError(e)}");
//     } catch (e) {
//       throw ApiFailure(message: "❌ Unexpected Error: $e");
//     }
//   }

//   /// ✅ **Clear Entire Cart**
//   @override
//   Future<void> clearCart(String userId) async {
//     try {
//       final token = await _getAuthToken();
//       final url = "${ApiEndpoints.clearCart}/$userId";

//       final response = await _dio.delete(
//         url,
//         options: Options(headers: _buildHeaders(token)),
//       );

//       if (response.statusCode != 200) {
//         throw const ApiFailure(message: "❌ Failed to clear cart");
//       }
//     } on DioException catch (e) {
//       throw ApiFailure(message: "❌ API Error: ${_handleDioError(e)}");
//     } catch (e) {
//       throw ApiFailure(message: "❌ Unexpected Error: $e");
//     }
//   }

//   /// ✅ **Helper Function to Build Headers**
//   Map<String, String> _buildHeaders(String token) {
//     return {
//       "Authorization": "Bearer $token",
//       "Content-Type": "application/json",
//     };
//   }

//   /// ✅ **Dio Error Handling**
//   String _handleDioError(DioException e) {
//     switch (e.type) {
//       case DioExceptionType.connectionTimeout:
//         return "Connection Timeout. Please try again.";
//       case DioExceptionType.receiveTimeout:
//         return "Receive Timeout. Please check your internet connection.";
//       case DioExceptionType.badResponse:
//         return "Bad Response: ${e.response?.data["message"] ?? "Unknown error"}";
//       case DioExceptionType.unknown:
//         return "Unknown error occurred. Please try again.";
//       default:
//         return "An unexpected error occurred.";
//     }
//   }
// }
