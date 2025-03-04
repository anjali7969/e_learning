// import 'package:e_learning/features/cart/domain/entity/cart_item_entity.dart';
// import 'package:equatable/equatable.dart';

// abstract class CartEvent extends Equatable {
//   const CartEvent();

//   @override
//   List<Object?> get props => [];
// }

// /// ✅ Load Cart Event
// class LoadCart extends CartEvent {
//   final String userId;

//   const LoadCart({required this.userId});

//   @override
//   List<Object?> get props => [userId];
// }

// /// ✅ Add Item to Cart Event
// class AddCartItem extends CartEvent {
//   final String userId;
//   final CartItemEntity item;

//   const AddCartItem({required this.userId, required this.item});

//   @override
//   List<Object?> get props => [userId, item];
// }

// /// ✅ Update Item Quantity in Cart Event
// class UpdateCartItem extends CartEvent {
//   final String userId;
//   final String courseId;
//   final int quantity;

//   const UpdateCartItem(
//       {required this.userId, required this.courseId, required this.quantity});

//   @override
//   List<Object?> get props => [userId, courseId, quantity];
// }

// /// ✅ Remove Item from Cart Event
// class RemoveCartItem extends CartEvent {
//   final String userId;
//   final String courseId;

//   const RemoveCartItem({required this.userId, required this.courseId});

//   @override
//   List<Object?> get props => [userId, courseId];
// }

// /// ✅ Clear Cart Event
// class ClearCart extends CartEvent {
//   final String userId;

//   const ClearCart({required this.userId});

//   @override
//   List<Object?> get props => [userId];
// }
