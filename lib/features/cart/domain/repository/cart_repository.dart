import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';

import '../entity/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart>> getCart(String userId);
  Future<Either<Failure, void>> addToCart(String userId, CartItem item);
  Future<Either<Failure, void>> updateCartItem(
      String userId, String courseId, int quantity);
  Future<Either<Failure, void>> removeCartItem(String userId, String courseId);
  Future<Either<Failure, void>> clearCart(String userId);
}
