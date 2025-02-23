import 'package:dartz/dartz.dart';
import 'package:e_learning/features/cart/domain/repository/cart_repository.dart';

class RemoveCartItem {
  final CartRepository repository;

  RemoveCartItem(this.repository);

  Future<Either<String, void>> call(String userId, String courseId) async {
    try {
      await repository.removeCartItem(userId, courseId);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
