import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String courseId;
  final String name;
  final double price;
  final String image;
  final String description;
  final int quantity;

  const CartItem({
    required this.courseId,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.quantity,
  });

  @override
  List<Object?> get props =>
      [courseId, name, price, image, description, quantity];
}

class Cart extends Equatable {
  final String userId;
  final List<CartItem> items;

  const Cart({
    required this.userId,
    required this.items,
  });

  @override
  List<Object?> get props => [userId, items];
}
