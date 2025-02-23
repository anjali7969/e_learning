import 'package:e_learning/features/cart/domain/entity/cart_entity.dart';
import 'package:e_learning/features/cart/domain/use_case/add_to_cart_usecase.dart';
import 'package:e_learning/features/cart/domain/use_case/clear_cart_usecase.dart';
import 'package:e_learning/features/cart/domain/use_case/get_cart_usecase.dart';
import 'package:e_learning/features/cart/domain/use_case/remove_cart_usecase.dart';
import 'package:e_learning/features/cart/domain/use_case/update_cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUsecase getCartUsecase;
  final AddToCartUsecase addToCartUsecase;
  final UpdateCartItem updateCartItem;
  final RemoveCartItem removeCartItem;
  final ClearCart clearCart;

  CartCubit({
    required this.getCartUsecase,
    required this.addToCartUsecase,
    required this.updateCartItem,
    required this.removeCartItem,
    required this.clearCart,
  }) : super(CartInitial());

  /// ✅ Fetch User Cart
  Future<void> fetchCart(String userId) async {
    emit(CartLoaded(
        cartItemCount: 0, cart: Cart(userId: userId, items: const [])));
    final result = await getCartUsecase(userId);

    result.fold(
      (failure) =>
          emit(CartError(failure as String)), // ❌ Fixed `failure.message` issue
      (cart) => emit(CartLoaded(cart: cart, cartItemCount: cart.items.length)),
    );
  }

  /// ✅ Add Item to Cart
  Future<void> addItemToCart(String userId, CartItem item) async {
    final result = await addToCartUsecase(userId, item);

    result.fold(
      (failure) => emit(CartError(failure)), // ❌ Fixed here too
      (_) => fetchCart(userId),
    );
  }

  /// ✅ Update Cart Item Quantity
  Future<void> updateCartItemQuantity(
      String userId, String courseId, int quantity) async {
    final result = await updateCartItem(userId, courseId, quantity);

    result.fold(
      (failure) => emit(CartError(failure)), // ❌ Fixed
      (_) => fetchCart(userId),
    );
  }

  /// ✅ Remove Item from Cart
  Future<void> removeItemFromCart(String userId, String courseId) async {
    final result = await removeCartItem(userId, courseId);

    result.fold(
      (failure) => emit(CartError(failure)), // ❌ Fixed
      (_) => fetchCart(userId),
    );
  }

  /// ✅ Clear User Cart
  Future<void> clearUserCart(String userId) async {
    final result = await clearCart(userId);

    result.fold(
      (failure) => emit(CartError(failure)), // ❌ Fixed
      (_) => emit(CartLoaded(
          cart: Cart(userId: userId, items: const []), cartItemCount: 0)),
    );
  }
}
