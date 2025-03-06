// import 'package:dartz/dartz.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:e_learning/features/cart/domain/entity/cart_item_entity.dart';
// import 'package:e_learning/features/cart/domain/repository/cart_repository.dart';

// /// **✅ Get User Cart Use Case**
// class GetCartUsecase {
//   final CartRepository repository;

//   GetCartUsecase({required this.repository});

//   Future<Either<Failure, List<CartItemEntity>>> call(String userId) {
//     return repository.getCart(userId);
//   }
// }

// /// **✅ Add Course to Cart Use Case**
// class AddToCartUsecase {
//   final CartRepository repository;

//   AddToCartUsecase({required this.repository});

//   Future<Either<Failure, void>> call(String userId, CartItemEntity item) {
//     return repository.addToCart(userId, item);
//   }
// }

// /// **✅ Update Cart Item Quantity Use Case**
// class UpdateCartUsecase {
//   final CartRepository repository;

//   UpdateCartUsecase({required this.repository});

//   Future<Either<Failure, void>> call(
//       String userId, String courseId, int quantity) {
//     return repository.updateCart(userId, courseId, quantity);
//   }
// }

// /// **✅ Remove Course from Cart Use Case**
// class RemoveCartUsecase {
//   final CartRepository repository;

//   RemoveCartUsecase({required this.repository});

//   Future<Either<Failure, void>> call(String userId, String courseId) {
//     return repository.removeCart(userId, courseId);
//   }
// }

// /// **✅ Clear User Cart Use Case**
// class ClearCartUsecase {
//   final CartRepository repository;

//   ClearCartUsecase({required this.repository});

//   Future<Either<Failure, void>> call(String userId) {
//     return repository.clearCart(userId);
//   }
// }
