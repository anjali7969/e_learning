import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';
import 'package:e_learning/features/cart/data/data_source/remote_datasource/cart_remote_datasource.dart';
import 'package:e_learning/features/cart/domain/entity/cart_entity.dart';
import 'package:e_learning/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  /// ✅ Get User Cart
  @override
  Future<Either<Failure, Cart>> getCart(String userId) async {
    try {
      final cart = await remoteDataSource.getCart(userId);
      return Right(cart);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Add Item to Cart
  @override
  Future<Either<Failure, void>> addToCart(String userId, CartItem item) async {
    try {
      await remoteDataSource.addToCart(userId, item);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Update Cart Item
  @override
  Future<Either<Failure, void>> updateCartItem(
      String userId, String courseId, int quantity) async {
    try {
      await remoteDataSource.updateCartItem(userId, courseId, quantity);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Remove Item from Cart
  @override
  Future<Either<Failure, void>> removeCartItem(
      String userId, String courseId) async {
    try {
      await remoteDataSource.removeCartItem(userId, courseId);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Clear Entire Cart
  @override
  Future<Either<Failure, void>> clearCart(String userId) async {
    try {
      await remoteDataSource.clearCart(userId);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
