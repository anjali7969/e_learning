// import 'package:dartz/dartz.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:e_learning/features/cart/data/data_source/remote_datasource/cart_remote_datasource.dart';
// import 'package:e_learning/features/cart/domain/entity/cart_item_entity.dart';
// import 'package:e_learning/features/cart/domain/repository/cart_repository.dart';

// class CartRepositoryImpl implements CartRepository {
//   final ICartRemoteDataSource remoteDataSource;

//   CartRepositoryImpl({required this.remoteDataSource}); // ✅ Remove extra param

//   /// ✅ Add Item to Cart
//   @override
//   Future<Either<Failure, void>> addToCart(
//       String userId, CartItemEntity cartItem) async {
//     try {
//       await remoteDataSource.addToCart(userId, cartItem);
//       return const Right(null);
//     } catch (e) {
//       return Left(
//           ApiFailure(message: "Failed to add item to cart: ${e.toString()}"));
//     }
//   }

//   /// ✅ Fetch Cart Items
//   @override
//   Future<Either<Failure, List<CartItemEntity>>> getCart(String userId) async {
//     try {
//       final cartEntity = await remoteDataSource.getCart(userId);
//       final result = cartEntity
//           .items; // Assuming CartEntity has a property 'items' of type List<CartItemEntity>
//       return Right(result);
//     } catch (e) {
//       return Left(
//           ApiFailure(message: "Failed to fetch cart items: ${e.toString()}"));
//     }
//   }

//   /// ✅ Remove an Item from Cart
//   @override
//   Future<Either<Failure, void>> removeCart(
//       String userId, String courseId) async {
//     try {
//       await remoteDataSource.removeCartItem(
//           userId, courseId); // ✅ Fixed method name
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(
//           message: "Failed to remove item from cart: ${e.toString()}"));
//     }
//   }

//   /// ✅ Clear Entire Cart
//   @override
//   Future<Either<Failure, void>> clearCart(String userId) async {
//     try {
//       await remoteDataSource.clearCart(userId); // ✅ Fixed method call
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: "Failed to clear cart: ${e.toString()}"));
//     }
//   }

//   /// ✅ Update Cart Item Quantity
//   @override
//   Future<Either<Failure, void>> updateCart(
//       String userId, String courseId, int quantity) async {
//     try {
//       await remoteDataSource.updateCartItem(
//           userId, courseId, quantity); // ✅ Fixed call
//       return const Right(null);
//     } catch (e) {
//       return Left(
//           ApiFailure(message: "Failed to update cart: ${e.toString()}"));
//     }
//   }
// }
