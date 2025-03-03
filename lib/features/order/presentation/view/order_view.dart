// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../view_model/cubit/cart_cubit.dart';
// import '../view_model/cubit/cart_state.dart';

// class ShoppingCartScreen extends StatefulWidget {
//   final String userId;

//   const ShoppingCartScreen({super.key, required this.userId});

//   @override
//   _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
// }

// class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<CartCubit>().fetchCart(widget.userId); // ✅ Fixed method call
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Shopping Cart")),
//       body: BlocBuilder<CartCubit, CartState>(
//         builder: (context, state) {
//           if (state is CartLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is CartError) {
//             return Center(child: Text("Error: ${state.message}"));
//           }

//           if (state is CartLoaded && state.cart.items.isEmpty) {
//             return const Center(child: Text("Your cart is empty."));
//           }

//           if (state is CartLoaded) {
//             return Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 children: [
//                   // 🛒 Order Summary
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: state.cart.items.length,
//                       itemBuilder: (context, index) {
//                         final item = state.cart.items[index];

//                         return Card(
//                           margin: const EdgeInsets.symmetric(vertical: 8),
//                           child: ListTile(
//                             leading: Image.network(
//                               item.image,
//                               width: 80,
//                               height: 80,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) =>
//                                   const Icon(Icons.image_not_supported),
//                             ),
//                             title: Text(
//                               item.name,
//                               style: const TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ),
//                             subtitle:
//                                 Text("\$${item.price} x ${item.quantity}"),
//                             trailing: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(Icons.remove),
//                                   onPressed: () {
//                                     if (item.quantity > 1) {
//                                       context
//                                           .read<CartCubit>()
//                                           .updateCartItemQuantity(widget.userId,
//                                               item.courseId, item.quantity - 1);
//                                     }
//                                   },
//                                 ),
//                                 Text("${item.quantity}"),
//                                 IconButton(
//                                   icon: const Icon(Icons.add),
//                                   onPressed: () {
//                                     context
//                                         .read<CartCubit>()
//                                         .updateCartItemQuantity(widget.userId,
//                                             item.courseId, item.quantity + 1);
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.delete,
//                                       color: Colors.red),
//                                   onPressed: () {
//                                     context
//                                         .read<CartCubit>()
//                                         .removeItemFromCart(
//                                             widget.userId, item.courseId);
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//                   // 🛍 Checkout Section
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(color: Colors.black12, blurRadius: 4)
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text("Total:",
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold)),
//                             Text(
//                               "\$${state.cart.items.fold(0.0, (sum, item) => sum + (item.price * item.quantity)).toStringAsFixed(2)}",
//                               style: const TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.red),
//                                 onPressed: () {
//                                   context
//                                       .read<CartCubit>()
//                                       .clearUserCart(widget.userId);
//                                 },
//                                 child: const Text("Clear Cart"),
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   _showOrderDialog(context);
//                                 },
//                                 child: const Text("Checkout"),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return const Center(child: Text("Something went wrong."));
//         },
//       ),
//     );
//   }

//   /// ✅ Show Order Confirmation Popup
//   void _showOrderDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Confirm Order"),
//         content: const Text("Are you sure you want to place this order?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("Order placed successfully!")),
//               );
//             },
//             child: const Text("Confirm"),
//           ),
//         ],
//       ),
//     );
//   }
// }
