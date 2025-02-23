import 'package:dartz/dartz.dart';
import 'package:e_learning/core/error/failure.dart';

import '../entity/cart_entity.dart';
import '../repository/cart_repository.dart';

class GetCartUsecase {
  final CartRepository repository;

  GetCartUsecase(this.repository);

  Future<Either<Failure, Cart>> call(String userId) async {
    return await repository.getCart(userId);
  }
}
