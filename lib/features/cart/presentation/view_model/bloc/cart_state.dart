// import 'package:e_learning/features/cart/domain/entity/cart_item_entity.dart';
// import 'package:equatable/equatable.dart';

// class CartState extends Equatable {
//   final List<CartItemEntity> cartItems;
//   final bool isLoading;
//   final String? error;

//   const CartState({
//     required this.cartItems,
//     required this.isLoading,
//     this.error,
//   });

//   factory CartState.initial() {
//     return const CartState(
//       cartItems: [],
//       isLoading: false,
//       error: null,
//     );
//   }

//   CartState copyWith({
//     List<CartItemEntity>? cartItems,
//     bool? isLoading,
//     String? error,
//   }) {
//     return CartState(
//       cartItems: cartItems ?? this.cartItems,
//       isLoading: isLoading ?? this.isLoading,
//       error: error, // Preserve error state when necessary
//     );
//   }

//   @override
//   List<Object?> get props => [cartItems, isLoading, error];
// }
