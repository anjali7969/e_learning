import 'package:e_learning/features/cart/domain/entity/cart_entity.dart';

abstract interface class ICartDataSource {
  Future<List<CartItem>> getCart();
}
