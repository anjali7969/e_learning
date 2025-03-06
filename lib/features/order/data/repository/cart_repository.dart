// import 'package:dartz/dartz.dart';
// import 'package:e_learning/core/error/failure.dart';
// import 'package:e_learning/features/order/data/data_source/order_datasource.dart';
// import 'package:e_learning/features/order/domain/entity/order_entity.dart';
// import 'package:e_learning/features/order/domain/repository/order_repository.dart';

// class OrderRepositoryImpl implements OrderRepository {
//   final OrderDatasource _orderDatasource;

//   OrderRepositoryImpl({required OrderDatasource orderDatasource})
//       : _orderDatasource = orderDatasource;

//   /// ✅ **Confirm an Order**
//   @override
//   Future<Either<Failure, OrderEntity>> orderConfirm(OrderEntity order) async {
//     try {
//       final result = await _orderDatasource.confirmOrder(order);
//       return Right(result);
//     } catch (e) {
//       return Left(
//           ApiFailure(message: "Failed to confirm order: ${e.toString()}"));
//     }
//   }

//   /// ✅ **Fetch User Orders**
//   @override
//   Future<Either<Failure, List<OrderEntity>>> getOrder(String userId) async {
//     try {
//       final result = await _orderDatasource.getUserOrders(userId);
//       return Right(result); // ✅ Ensuring it returns List<OrderEntity>
//     } catch (e) {
//       return Left(
//           ApiFailure(message: "Failed to fetch user orders: ${e.toString()}"));
//     }
//   }

//   /// ✅ **Cancel an Order**
//   // @override
//   // Future<Either<Failure, void>> cancelOrder(String orderId) async {
//   //   try {
//   //     await _orderDatasource.cancelOrder(orderId);
//   //     return const Right(null);
//   //   } catch (e) {
//   //     return Left(
//   //         ApiFailure(message: "Failed to cancel order: ${e.toString()}"));
//   //   }
//   // }
// }
