// import 'package:e_learning/features/order/domain/entity/order_entity.dart';
// import 'package:equatable/equatable.dart';

// /// **Abstract Order State**
// abstract class OrderState extends Equatable {
//   const OrderState();

//   @override
//   List<Object?> get props => [];
// }

// /// **Initial Order State**
// class OrderInitial extends OrderState {}

// /// **Order Loading State**
// class OrderLoading extends OrderState {}

// /// **Order Successfully Placed State**
// class OrderSuccess extends OrderState {
//   final OrderEntity order;

//   const OrderSuccess(this.order);

//   @override
//   List<Object?> get props => [order];
// }

// /// **Order List Loaded (For User Orders)**
// class OrdersLoaded extends OrderState {
//   final List<OrderEntity> orders;

//   const OrdersLoaded(this.orders);

//   @override
//   List<Object?> get props => [orders];
// }

// /// **Order Failure State**
// class OrderFailure extends OrderState {
//   final String message;

//   const OrderFailure(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// class OrderError extends OrderState {
//   final String message;
//   const OrderError(this.message);
// }

// class OrderConfirmed extends OrderState {
//   final OrderEntity order;
//   const OrderConfirmed(this.order);
// }
