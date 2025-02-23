import 'package:dartz/dartz.dart';
import 'package:e_learning/features/cart/domain/entity/cart_entity.dart';
import 'package:e_learning/features/cart/domain/repository/cart_repository.dart';

class AddToCartUsecase {
  final CartRepository repository;

  AddToCartUsecase(this.repository);

  Future<Either<String, void>> call(String userId, CartItem item) async {
    try {
      await repository.addToCart(userId, item);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
