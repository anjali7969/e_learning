import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  /// **Function to Get Image URL**
  String getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.trim().isEmpty) {
      return "https://via.placeholder.com/150"; // ✅ Use a default placeholder
    }
    return "http://10.0.2.2:5003${imagePath.trim()}"; // ✅ Backend URL
  }

  @override
  Widget build(BuildContext context) {
    // 🛒 **Static Cart Items (Simulating Backend Response)**
    final List<Map<String, dynamic>> cartItems = [
      {
        "name": "UI/UX Design",
        "price": 1000.0,
        "quantity": 1,
        "image":
            "/uploads/courses/IMG-1739801704798-download.png", // ✅ Image path from backend
      },
      // {
      //   "name": "Flutter Development",
      //   "price": 1200.0,
      //   "quantity": 1,
      //   "image": "/uploads/flutter_dev.png", // ✅ Image path from backend
      // },
    ];

    double totalAmount = cartItems.fold(
        0.0, (sum, item) => sum + (item['price'] * item['quantity']));

    return Scaffold(
      appBar: AppBar(title: const Text("Shopping Cart")),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // 📌 **Cart Items UI**
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // ✅ Load image from backend, fallback to placeholder on error
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              getImageUrl(item['image']),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.network(
                                "https://via.placeholder.com/150",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Price: \$${item['price'].toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text("x${item['quantity']}",
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // 📌 **Shopping Cart Summary**
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 4, spreadRadius: 1)
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("\$${totalAmount.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 📌 **Order & Cancel Buttons**
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Order Cancelled"),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Order Placed Successfully!"),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Place Order",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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

//           if (state is CartLoaded && state.cart.entity.isEmpty) {
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
//                       itemCount: state.cart.entity.length,
//                       itemBuilder: (context, index) {
//                         final item = state.cart.entity[index];

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
//                               "\$${state.cart.entity.fold(0.0, (sum, item) => sum + (item.price * item.quantity)).toStringAsFixed(2)}",
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

// import 'package:e_learning/features/cart/domain/entity/cart_entity.dart';
// import 'package:e_learning/features/cart/presentation/view_model/cubit/cart_cubit.dart';
// import 'package:e_learning/features/order/domain/entity/order_entity.dart';
// import 'package:e_learning/features/order/presentation/view_model/cubit/order_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../view_model/cubit/cart_state.dart';

// class ShoppingCartScreen extends StatefulWidget {
//   final String userId;

//   const ShoppingCartScreen({super.key, required this.userId});

//   @override
//   _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
// }

// class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
//   String selectedPaymentMethod = "Card Payment";
//   final TextEditingController phoneNumberController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     context.read<CartCubit>().fetchCart(widget.userId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Shopping Cart")),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Order Summary",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             BlocBuilder<CartCubit, CartState>(
//               builder: (context, state) {
//                 if (state is CartLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (state is CartError) {
//                   return Center(child: Text("Error: ${state.message}"));
//                 }
//                 if (state is CartLoaded && state.cart.items.isEmpty) {
//                   return const Center(
//                       child: Text(
//                     "Your cart is empty.",
//                     style: TextStyle(fontSize: 16, color: Colors.black54),
//                   ));
//                 }

//                 if (state is CartLoaded) {
//                   double totalAmount = state.cart.items.fold(
//                       0.0, (sum, item) => sum + (item.price * item.quantity));

//                   return Column(
//                     children: [
//                       /// 🛍 **Order Summary**
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.grey.shade300),
//                         ),
//                         child: Column(
//                           children: state.cart.items.map((item) {
//                             return Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(item.name,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16)),
//                                     Row(
//                                       children: [
//                                         IconButton(
//                                           icon: const Icon(Icons.remove_circle,
//                                               color: Colors.redAccent),
//                                           onPressed: () {
//                                             if (item.quantity > 1) {
//                                               context
//                                                   .read<CartCubit>()
//                                                   .updateCartItemQuantity(
//                                                       widget.userId,
//                                                       item.courseId,
//                                                       item.quantity - 1);
//                                             }
//                                           },
//                                         ),
//                                         Text("${item.quantity}"),
//                                         IconButton(
//                                           icon: const Icon(Icons.add_circle,
//                                               color: Colors.green),
//                                           onPressed: () {
//                                             context
//                                                 .read<CartCubit>()
//                                                 .updateCartItemQuantity(
//                                                     widget.userId,
//                                                     item.courseId,
//                                                     item.quantity + 1);
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 Text(
//                                     "\$${(item.price * item.quantity).toStringAsFixed(2)}",
//                                     style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold)),
//                                 TextButton(
//                                   onPressed: () {
//                                     context
//                                         .read<CartCubit>()
//                                         .removeItemFromCart(
//                                             widget.userId, item.courseId);
//                                   },
//                                   child: const Text(
//                                     "Remove",
//                                     style: TextStyle(
//                                         color: Colors.redAccent, fontSize: 14),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       const SizedBox(height: 20),

//                       /// 🛒 **Shopping Cart Summary**
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.grey.shade300),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Colors.black12,
//                                 blurRadius: 4,
//                                 spreadRadius: 1)
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text("Shopping Cart",
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold)),
//                                 Text("${state.cart.items.length} Items",
//                                     style: const TextStyle(
//                                         color: Colors.blueAccent,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold)),
//                               ],
//                             ),
//                             const Divider(height: 20),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text("Subtotal:",
//                                     style: TextStyle(fontSize: 16)),
//                                 Text("\$${totalAmount.toStringAsFixed(2)}",
//                                     style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold)),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text("Total:",
//                                     style: TextStyle(fontSize: 18)),
//                                 Text("\$${totalAmount.toStringAsFixed(2)}",
//                                     style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold)),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),

//                       /// 📌 **Phone Number Input**
//                       TextField(
//                         controller: phoneNumberController,
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                           hintText: "Phone Number",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8)),
//                           contentPadding:
//                               const EdgeInsets.symmetric(horizontal: 12),
//                         ),
//                       ),

//                       const SizedBox(height: 10),

//                       /// 📌 **Payment Options**
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text("Payment",
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold)),
//                           ListTile(
//                             leading: Radio(
//                               value: "Card Payment",
//                               groupValue: selectedPaymentMethod,
//                               onChanged: (value) {
//                                 setState(() {
//                                   selectedPaymentMethod = value.toString();
//                                 });
//                               },
//                             ),
//                             title: const Text("Card Payment"),
//                           ),
//                           ListTile(
//                             leading: Radio(
//                               value: "PayPal Payment",
//                               groupValue: selectedPaymentMethod,
//                               onChanged: (value) {
//                                 setState(() {
//                                   selectedPaymentMethod = value.toString();
//                                 });
//                               },
//                             ),
//                             title: const Text("PayPal Payment"),
//                           ),
//                         ],
//                       ),

//                       /// 📌 **Order & Cancel Buttons**
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.grey),
//                             onPressed: () {
//                               context
//                                   .read<CartCubit>()
//                                   .clearUserCart(widget.userId);
//                             },
//                             child: const Text("Cancel",
//                                 style: TextStyle(color: Colors.black)),
//                           ),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blueAccent),
//                             onPressed: () {
//                               _confirmOrder(context, state.cart);
//                             },
//                             child: const Text("Order",
//                                 style: TextStyle(color: Colors.white)),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 }

//                 return const SizedBox();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:e_learning/features/cart/domain/use_case/cart_usecase.dart';
// import 'package:e_learning/features/cart/presentation/view_model/bloc/cart_bloc.dart';
// import 'package:e_learning/features/cart/presentation/view_model/bloc/cart_event.dart';
// import 'package:e_learning/features/cart/presentation/view_model/bloc/cart_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ShoppingCartScreen extends StatefulWidget {
//   final String userId; // ✅ Added missing userId property

//   const ShoppingCartScreen({super.key, required this.userId});

//   @override
//   _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
// }

// class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
//   String selectedPaymentMethod = "Card Payment";
//   final TextEditingController phoneNumberController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     // ✅ Fix: Ensure context is available before using it
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         context.read<CartBloc>().add(LoadCart(userId: widget.userId));
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CartBloc(
//         getCartUsecase: context.read<GetCartUsecase>(),
//         addToCartUsecase: context.read<AddToCartUsecase>(),
//         updateCartUsecase: context.read<UpdateCartUsecase>(),
//         removeCartUsecase: context.read<RemoveCartUsecase>(),
//         clearCartUsecase: context.read<ClearCartUsecase>(),
//       )..add(LoadCart(userId: widget.userId)), // ✅ Providing Bloc here
//       child: Scaffold(
//         appBar: AppBar(title: const Text("Shopping Cart")),
//         backgroundColor: Colors.white,
//         body: BlocListener<CartBloc, CartState>(
//           listener: (context, state) {
//             if (state.error != null) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("Error: ${state.error}")),
//               );
//             }
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text("Order Summary",
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),
//                 BlocBuilder<CartBloc, CartState>(
//                   builder: (context, state) {
//                     if (state.isLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     if (state.cartItems.isEmpty) {
//                       return const Center(
//                           child: Text(
//                         "Your cart is empty.",
//                         style: TextStyle(fontSize: 16, color: Colors.black54),
//                       ));
//                     }

//                     double totalAmount = state.cartItems.fold(
//                         0.0, (sum, item) => sum + (item.price * item.quantity));

//                     return Column(
//                       children: [
//                         /// 🛍 **Order Summary**
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.grey.shade300),
//                           ),
//                           child: Column(
//                             children: state.cartItems.map((item) {
//                               return Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(item.name,
//                                           style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16)),
//                                       Row(
//                                         children: [
//                                           IconButton(
//                                             icon: const Icon(
//                                                 Icons.remove_circle,
//                                                 color: Colors.redAccent),
//                                             onPressed: () {
//                                               if (item.quantity > 1) {
//                                                 context.read<CartBloc>().add(
//                                                       UpdateCartItem(
//                                                         userId: widget.userId,
//                                                         courseId: item.courseId,
//                                                         quantity:
//                                                             item.quantity - 1,
//                                                       ),
//                                                     );
//                                               }
//                                             },
//                                           ),
//                                           Text("${item.quantity}"),
//                                           IconButton(
//                                             icon: const Icon(Icons.add_circle,
//                                                 color: Colors.green),
//                                             onPressed: () {
//                                               context.read<CartBloc>().add(
//                                                     UpdateCartItem(
//                                                       userId: widget.userId,
//                                                       courseId: item.courseId,
//                                                       quantity:
//                                                           item.quantity + 1,
//                                                     ),
//                                                   );
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   Text(
//                                       "\$${(item.price * item.quantity).toStringAsFixed(2)}",
//                                       style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold)),
//                                   TextButton(
//                                     onPressed: () {
//                                       context.read<CartBloc>().add(
//                                             RemoveCartItem(
//                                               userId: widget.userId,
//                                               courseId: item.courseId,
//                                             ),
//                                           );
//                                     },
//                                     child: const Text(
//                                       "Remove",
//                                       style: TextStyle(
//                                           color: Colors.redAccent,
//                                           fontSize: 14),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         /// 🛒 **Shopping Cart Summary**
//                         Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.grey.shade300),
//                             boxShadow: const [
//                               BoxShadow(
//                                   color: Colors.black12,
//                                   blurRadius: 4,
//                                   spreadRadius: 1)
//                             ],
//                           ),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text("Shopping Cart",
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold)),
//                                   Text("${state.cartItems.length} Items",
//                                       style: const TextStyle(
//                                           color: Colors.blueAccent,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold)),
//                                 ],
//                               ),
//                               const Divider(height: 20),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text("Subtotal:",
//                                       style: TextStyle(fontSize: 16)),
//                                   Text("\$${totalAmount.toStringAsFixed(2)}",
//                                       style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold)),
//                                 ],
//                               ),
//                               const SizedBox(height: 10),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text("Total:",
//                                       style: TextStyle(fontSize: 18)),
//                                   Text("\$${totalAmount.toStringAsFixed(2)}",
//                                       style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         /// 📌 **Phone Number Input**
//                         TextField(
//                           controller: phoneNumberController,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             hintText: "Phone Number",
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8)),
//                             contentPadding:
//                                 const EdgeInsets.symmetric(horizontal: 12),
//                           ),
//                         ),

//                         const SizedBox(height: 10),

//                         /// 📌 **Payment Options**
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text("Payment",
//                                 style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.bold)),
//                             ListTile(
//                               leading: Radio(
//                                 value: "Card Payment",
//                                 groupValue: selectedPaymentMethod,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedPaymentMethod = value.toString();
//                                   });
//                                 },
//                               ),
//                               title: const Text("Card Payment"),
//                             ),
//                           ],
//                         ),

//                         /// 📌 **Order & Cancel Buttons**
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             ElevatedButton(
//                               onPressed: () {
//                                 context.read<CartBloc>().add(
//                                       ClearCart(userId: widget.userId),
//                                     );
//                               },
//                               child: const Text("Cancel"),
//                             ),
//                           ],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
