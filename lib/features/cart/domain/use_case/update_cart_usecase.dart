import 'package:dartz/dartz.dart';
import 'package:e_learning/features/cart/domain/repository/cart_repository.dart';

class UpdateCartItem {
  final CartRepository repository;

  UpdateCartItem(this.repository);

  Future<Either<String, void>> call(
      String userId, String courseId, int quantity) async {
    try {
      await repository.updateCartItem(userId, courseId, quantity);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
