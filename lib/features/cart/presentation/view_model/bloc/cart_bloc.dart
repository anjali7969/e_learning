// import 'package:bloc/bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:e_learning/features/cart/domain/entity/cart_item_entity.dart';
// import 'package:e_learning/features/cart/domain/use_case/cart_usecase.dart';
// import 'package:e_learning/features/cart/presentation/view_model/bloc/cart_event.dart';
// import 'package:e_learning/features/cart/presentation/view_model/bloc/cart_state.dart';

// class CartBloc extends Bloc<CartEvent, CartState> {
//   final GetCartUsecase _getCartUsecase;
//   final AddToCartUsecase _addToCartUsecase;
//   final UpdateCartUsecase _updateCartUsecase;
//   final RemoveCartUsecase _removeCartUsecase;
//   final ClearCartUsecase _clearCartUsecase;

//   CartBloc({
//     required GetCartUsecase getCartUsecase,
//     required AddToCartUsecase addToCartUsecase,
//     required UpdateCartUsecase updateCartUsecase,
//     required RemoveCartUsecase removeCartUsecase,
//     required ClearCartUsecase clearCartUsecase,
//   })  : _getCartUsecase = getCartUsecase,
//         _addToCartUsecase = addToCartUsecase,
//         _updateCartUsecase = updateCartUsecase,
//         _removeCartUsecase = removeCartUsecase,
//         _clearCartUsecase = clearCartUsecase,
//         super(CartState.initial()) {
//     on<LoadCart>(_onLoadCart);
//     on<AddCartItem>(_onAddCartItem);
//     on<UpdateCartItem>(_onUpdateCartItem);
//     on<RemoveCartItem>(_onRemoveCartItem);
//     on<ClearCart>(_onClearCart);
//   }

//   /// ✅ **Fetch Cart Items**
//   Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
//     emit(state.copyWith(isLoading: true, error: null));

//     final Either<Failure, List<CartItemEntity>> result =
//         await _getCartUsecase(event.userId);

//     result.fold(
//       (failure) =>
//           emit(state.copyWith(isLoading: false, error: failure.message)),
//       (cartItems) => emit(
//         state.copyWith(isLoading: false, cartItems: cartItems, error: null),
//       ),
//     );
//   }

//   /// ✅ **Add Item to Cart**
//   Future<void> _onAddCartItem(
//       AddCartItem event, Emitter<CartState> emit) async {
//     emit(state.copyWith(isLoading: true, error: null));

//     final Either<Failure, void> result =
//         await _addToCartUsecase(event.userId, event.item);

//     result.fold(
//       (failure) =>
//           emit(state.copyWith(isLoading: false, error: failure.message)),
//       (_) =>
//           add(LoadCart(userId: event.userId)), // Refresh cart after adding item
//     );
//   }

//   /// ✅ **Update Item Quantity in Cart**
//   Future<void> _onUpdateCartItem(
//       UpdateCartItem event, Emitter<CartState> emit) async {
//     emit(state.copyWith(isLoading: true, error: null));

//     final Either<Failure, void> result =
//         await _updateCartUsecase(event.userId, event.courseId, event.quantity);

//     result.fold(
//       (failure) =>
//           emit(state.copyWith(isLoading: false, error: failure.message)),
//       (_) => add(LoadCart(userId: event.userId)), // Refresh cart after updating
//     );
//   }

//   /// ✅ **Remove Item from Cart**
//   Future<void> _onRemoveCartItem(
//       RemoveCartItem event, Emitter<CartState> emit) async {
//     emit(state.copyWith(isLoading: true, error: null));

//     final Either<Failure, void> result =
//         await _removeCartUsecase(event.userId, event.courseId);

//     result.fold(
//       (failure) =>
//           emit(state.copyWith(isLoading: false, error: failure.message)),
//       (_) => add(
//           LoadCart(userId: event.userId)), // Refresh cart after removing item
//     );
//   }

//   /// ✅ **Clear Entire Cart**
//   Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
//     emit(state.copyWith(isLoading: true, error: null));

//     final Either<Failure, void> result = await _clearCartUsecase(event.userId);

//     result.fold(
//       (failure) =>
//           emit(state.copyWith(isLoading: false, error: failure.message)),
//       (_) => add(LoadCart(userId: event.userId)), // Refresh cart after clearing
//     );
//   }
// }
