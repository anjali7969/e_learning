import 'package:e_learning/features/cart/domain/entity/cart_entity.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Cart cart;
  final int cartItemCount; // ✅ To track number of enrolled courses
  CartLoaded({required this.cart, required this.cartItemCount});
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
