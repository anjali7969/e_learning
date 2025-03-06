// import 'package:e_learning/features/order/domain/entity/order_entity.dart';
// import 'package:e_learning/features/order/domain/use_case/confirm_order_usecase.dart';
// import 'package:e_learning/features/order/domain/use_case/get_user_order_usecase.dart';
// import 'package:e_learning/features/order/presentation/view_model/cubit/cart_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class OrderCubit extends Cubit<OrderState> {
//   final ConfirmOrderUseCase confirmOrderUseCase;
//   final GetUserOrdersUseCase getUserOrdersUseCase;

//   OrderCubit({
//     required this.confirmOrderUseCase,
//     required this.getUserOrdersUseCase,
//   }) : super(OrderInitial());

//   void confirmOrder(OrderEntity order) async {
//     emit(OrderLoading());
//     final result = await confirmOrderUseCase(order);
//     result.fold(
//       (failure) => emit(OrderError(failure.message)),
//       (order) => emit(OrderConfirmed(order)),
//     );
//   }

//   void fetchUserOrders(String userId) async {
//     emit(OrderLoading());
//     final result = await getUserOrdersUseCase(userId);
//     result.fold(
//       (failure) => emit(OrderError(failure.message)),
//       (orders) => emit(OrdersLoaded(orders)),
//     );
//   }
// }
