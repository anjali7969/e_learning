import 'package:dio/dio.dart';
import 'package:e_learning/app/constants/api_endpoints.dart';
import 'package:e_learning/features/cart/data/dto/cart_dto.dart';
import 'package:e_learning/features/cart/domain/entity/cart_entity.dart';

/// **Cart Remote Data Source Interface**
abstract class ICartRemoteDataSource {
  Future<Cart> getCart(String userId);
  Future<void> addToCart(String userId, CartItem item);
  Future<void> updateCartItem(String userId, String courseId, int quantity);
  Future<void> removeCartItem(String userId, String courseId);
  Future<void> clearCart(String userId);
}

/// **Cart Remote Data Source Implementation Using Dio**
class CartRemoteDataSource implements ICartRemoteDataSource {
  final Dio _dio;

  CartRemoteDataSource(this._dio);

  /// ✅ **Get User Cart**
  @override
  Future<Cart> getCart(String userId) async {
    try {
      var response = await _dio.get("${ApiEndpoints.getCart}/$userId");

      if (response.statusCode == 200) {
        return CartDto.fromJson(response.data).toEntity();
      } else {
        throw Exception("Failed to load cart");
      }
    } on DioException catch (e) {
      throw Exception("API error: ${e.message}");
    }
  }

  /// ✅ **Add Item to Cart**
  @override
  Future<void> addToCart(String userId, CartItem item) async {
    try {
      var response = await _dio.post(
        ApiEndpoints.addToCart,
        data: {
          "userId": userId,
          "courseId": item.courseId,
          "name": item.name,
          "price": item.price,
          "image": item.image,
          "description": item.description,
          "quantity": item.quantity,
        },
      );

      if (response.statusCode != 201) {
        throw Exception("Failed to add item to cart");
      }
    } on DioException catch (e) {
      throw Exception("API error: ${e.message}");
    }
  }

  /// ✅ **Update Cart Item**
  @override
  Future<void> updateCartItem(
      String userId, String courseId, int quantity) async {
    try {
      var response = await _dio.put(
        "${ApiEndpoints.updateCartItem}/$userId/update",
        data: {
          "courseId": courseId,
          "quantity": quantity,
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to update cart item");
      }
    } on DioException catch (e) {
      throw Exception("API error: ${e.message}");
    }
  }

  /// ✅ **Remove Item from Cart**
  @override
  Future<void> removeCartItem(String userId, String courseId) async {
    try {
      var response = await _dio.delete(
        "${ApiEndpoints.removeCartItem}/$courseId",
        data: {
          "userId": userId,
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to remove item from cart");
      }
    } on DioException catch (e) {
      throw Exception("API error: ${e.message}");
    }
  }

  /// ✅ **Clear Entire Cart**
  @override
  Future<void> clearCart(String userId) async {
    try {
      var response = await _dio.delete("${ApiEndpoints.clearCart}/$userId");

      if (response.statusCode != 200) {
        throw Exception("Failed to clear cart");
      }
    } on DioException catch (e) {
      throw Exception("API error: ${e.message}");
    }
  }
}
