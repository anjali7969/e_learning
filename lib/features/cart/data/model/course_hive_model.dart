// import 'package:e_learning/features/cart/data/dto/cart_dto.dart';
// import 'package:e_learning/features/cart/data/model/cart_api_model.dart';

// import '../../domain/entities/cart.dart';
// import 'cart_item_model.dart';

// class CartModel extends Cart {
//   const CartModel({
//     required String userId,
//     required List<CartItemModel> super.items,
//   }) : super(
//           userId: userId,
//         );

//   factory CartModel.fromJson(Map<String, dynamic> json) {
//     return CartModel(
//       userId: json['userId'],
//       items: (json['items'] as List)
//           .map((item) => CartItemModel.fromJson(item))
//           .toList(),
//     );
//   }

//   @override
//   Map<String, dynamic> toJson() {
//     return {
//       'userId': userId,
//       'items': items.map((item) => (item as CartItemModel).toJson()).toList(),
//     };
//   }
// }
