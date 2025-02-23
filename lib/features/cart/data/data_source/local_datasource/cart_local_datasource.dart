import 'package:e_learning/features/cart/data/model/cart_api_model.dart';
import 'package:hive/hive.dart';

abstract class CartLocalDataSource {
  Future<void> saveCart(CartApiModel cart);
  Future<CartApiModel?> getCart();
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartApiModel> cartBox;

  CartLocalDataSourceImpl(this.cartBox);

  @override
  Future<void> saveCart(CartApiModel cart) async {
    await cartBox.put('cart', cart);
  }

  @override
  Future<CartApiModel?> getCart() async {
    return cartBox.get('cart');
  }

  @override
  Future<void> clearCart() async {
    await cartBox.clear();
  }
}
