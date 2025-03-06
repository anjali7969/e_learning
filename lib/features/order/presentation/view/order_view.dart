import 'dart:convert';

import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<dynamic> cartItems = [];
  bool isLoading = true;
  double totalPrice = 0.0;
  String? _userId;
  String? _token;
  String paymentMethod = "Card Payment"; // Default payment method
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// ✅ **Load User Data**
  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('userId');
      _token = prefs.getString('token');
    });

    if (_userId != null && _token != null) {
      fetchCartItems();
    }
  }

  /// ✅ **Fetch User's Cart**
  Future<void> fetchCartItems() async {
    try {
      final response = await http.get(
        Uri.parse("http://10.0.2.2:5003/cart/$_userId"),
        headers: {
          "Authorization": "Bearer $_token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        double total = 0.0;

        for (var item in data['cart']['items']) {
          total += item["price"] * item["quantity"];
        }

        setState(() {
          cartItems = data['cart']['items'];
          totalPrice = total;
          isLoading = false;
        });

        print("✅ Cart Items Loaded: $cartItems");
      } else {
        throw Exception("Failed to load cart items");
      }
    } catch (e) {
      print("❌ Error fetching cart items: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  /// ✅ **Remove Item from Cart**
  Future<void> removeFromCart(String courseId) async {
    try {
      final response = await http.delete(
        Uri.parse("http://10.0.2.2:5003/cart/remove"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token"
        },
        body: jsonEncode({"userId": _userId, "courseId": courseId}),
      );

      if (response.statusCode == 200) {
        fetchCartItems();
      } else {
        throw Exception("Failed to remove item from cart");
      }
    } catch (e) {
      print("❌ Error removing item: $e");
    }
  }

  /// ✅ **Clear Entire Cart**
  Future<void> clearCart() async {
    try {
      final response = await http.delete(
        Uri.parse("http://10.0.2.2:5003/cart/clear/$_userId"),
        headers: {
          "Authorization": "Bearer $_token",
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          cartItems = [];
          totalPrice = 0.0;
        });
        print("🛒 Cart cleared successfully!");
      } else {
        throw Exception("Failed to clear cart");
      }
    } catch (e) {
      print("❌ Error clearing cart: $e");
    }
  }

  /// ✅ **Confirm Order & Redirect to Home**
  Future<void> confirmOrder() async {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Cart cannot be empty"), backgroundColor: Colors.red),
      );
      return;
    }

    if (phoneNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please enter a phone number"),
            backgroundColor: Colors.red),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:5003/order/confirm"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        },
        body: jsonEncode({
          "cart": cartItems,
          "paymentMethod": paymentMethod,
          "phoneNumber": phoneNumberController.text,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Order placed successfully! 🎉"),
              backgroundColor: Colors.green),
        );

        // ✅ **Wait for Cart to be Cleared Before Navigating**
        await clearCart();

        setState(() {
          cartItems = [];
          totalPrice = 0.0;
        });

        print("🛒 Cart cleared after order placement!");

        // ✅ **Navigate to Home Page**
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomNavigationView()),
          (Route<dynamic> route) => false, // Clears all previous screens
        );
      } else {
        throw Exception("Failed to place order");
      }
    } catch (e) {
      print("❌ Error confirming order: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  /// ✅ **Build UI**
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Checkout",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
              ? const Center(child: Text("Your cart is empty!"))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // ✅ Course Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "http://10.0.2.2:5003${item["image"]}",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 15),

                                // ✅ Course Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item["name"],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "\$${item["price"]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        item["description"],
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    removeFromCart(item["courseId"]);
                                  },
                                  icon: const Icon(Icons.delete_outline,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 5),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ✅ Phone Number Input (Shows Black Border When Focused)
                          TextField(
                            controller: phoneNumberController,
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color:
                                        Colors.black), // Default Black Border
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2), // Black Border on Focus
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // ✅ Payment Method Dropdown (Same Styling as TextField)
                          DropdownButtonFormField<String>(
                            value: paymentMethod,
                            decoration: InputDecoration(
                              labelText: "Payment Method",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color:
                                        Colors.black), // Default Black Border
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2), // Black Border on Focus
                              ),
                            ),
                            items: ["Card Payment", "PayPal"]
                                .map((method) => DropdownMenuItem(
                                      value: method,
                                      child: Text(method),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                paymentMethod = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 15),

                          // ✅ Total Price
                          Text(
                            "Total: \$${totalPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 30),

                          // ✅ Checkout & Clear Cart Buttons (Same as CartPage)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 150, // Fixed width
                                height: 50, // Fixed height
                                child: OutlinedButton(
                                  onPressed: clearCart,
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.black), // Black Border
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: const Text("Clear Cart",
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ),
                              SizedBox(
                                width: 150, // Fixed width
                                height: 50, // Fixed height
                                child: ElevatedButton(
                                  onPressed: confirmOrder,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: const Text("Place Order",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
                 











// import 'dart:convert';

// import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_navigation_view.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class CheckoutPage extends StatefulWidget {
//   const CheckoutPage({super.key});

//   @override
//   _CheckoutPageState createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   List<dynamic> cartItems = [];
//   bool isLoading = true;
//   double totalPrice = 0.0;
//   String? _userId;
//   String? _token;
//   String paymentMethod = "Card Payment"; // Default payment method
//   TextEditingController phoneNumberController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   /// ✅ **Load User Data**
//   Future<void> _loadUserData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _userId = prefs.getString('userId');
//       _token = prefs.getString('token');
//     });

//     if (_userId != null && _token != null) {
//       fetchCartItems();
//     }
//   }

//   /// ✅ **Fetch User's Cart**
//   Future<void> fetchCartItems() async {
//     try {
//       final response = await http.get(
//         Uri.parse("http://10.0.2.2:5003/cart/$_userId"),
//         headers: {
//           "Authorization": "Bearer $_token",
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         double total = 0.0;

//         for (var item in data['cart']['items']) {
//           total += item["price"] * item["quantity"];
//         }

//         setState(() {
//           cartItems = data['cart']['items'];
//           totalPrice = total;
//           isLoading = false;
//         });

//         print("✅ Cart Items Loaded: $cartItems");
//       } else {
//         throw Exception("Failed to load cart items");
//       }
//     } catch (e) {
//       print("❌ Error fetching cart items: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   /// ✅ **Remove Item from Cart**
//   Future<void> removeFromCart(String courseId) async {
//     try {
//       final response = await http.delete(
//         Uri.parse("http://10.0.2.2:5003/cart/remove"),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $_token"
//         },
//         body: jsonEncode({"userId": _userId, "courseId": courseId}),
//       );

//       if (response.statusCode == 200) {
//         fetchCartItems();
//       } else {
//         throw Exception("Failed to remove item from cart");
//       }
//     } catch (e) {
//       print("❌ Error removing item: $e");
//     }
//   }

//   /// ✅ **Clear Entire Cart**
//   Future<void> clearCart() async {
//     try {
//       final response = await http.delete(
//         Uri.parse("http://10.0.2.2:5003/cart/clear/$_userId"),
//         headers: {
//           "Authorization": "Bearer $_token",
//         },
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           cartItems = [];
//           totalPrice = 0.0;
//         });
//         print("🛒 Cart cleared successfully!");
//       } else {
//         throw Exception("Failed to clear cart");
//       }
//     } catch (e) {
//       print("❌ Error clearing cart: $e");
//     }
//   }

//   /// ✅ **Confirm Order & Redirect to Home**
//   Future<void> confirmOrder() async {
//     if (cartItems.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text("Cart cannot be empty"), backgroundColor: Colors.red),
//       );
//       return;
//     }

//     if (phoneNumberController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text("Please enter a phone number"),
//             backgroundColor: Colors.red),
//       );
//       return;
//     }

//     try {
//       final response = await http.post(
//         Uri.parse("http://10.0.2.2:5003/order/confirm"),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $_token",
//         },
//         body: jsonEncode({
//           "cart": cartItems,
//           "paymentMethod": paymentMethod,
//           "phoneNumber": phoneNumberController.text,
//         }),
//       );

//       if (response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text("Order placed successfully! 🎉"),
//               backgroundColor: Colors.green),
//         );

//         // ✅ **Wait for Cart to be Cleared Before Navigating**
//         await clearCart();

//         setState(() {
//           cartItems = [];
//           totalPrice = 0.0;
//         });

//         print("🛒 Cart cleared after order placement!");

//         // ✅ **Navigate to Home Page (Modify Based on Your Project)**
//         Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => BottomNavigationView()),
//           (Route<dynamic> route) => false, // Clears all previous screens
//         );
//       } else {
//         throw Exception("Failed to place order");
//       }
//     } catch (e) {
//       print("❌ Error confirming order: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
//       );
//     }
//   }

//   /// ✅ **Build UI**
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text("Checkout",
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         backgroundColor: Colors.blue.shade800,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : cartItems.isEmpty
//               ? const Center(child: Text("Your cart is empty!"))
//               : Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: cartItems.length,
//                         itemBuilder: (context, index) {
//                           final item = cartItems[index];
//                           return Card(
//                             color: Colors.white,
//                             // Ensures Larger Size
//                             margin: const EdgeInsets.all(10),
//                             child: ListTile(
//                               leading: Image.network(
//                                 "http://10.0.2.2:5003${item["image"]}",
//                                 width: 50,
//                                 height: 50,
//                                 fit: BoxFit.cover,
//                               ),
//                               title: Text(item["name"]),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Price: \$${item["price"]}"),
//                                   Text("Description: ${item["description"]}"),
//                                 ],
//                               ),
//                               trailing: IconButton(
//                                 icon:
//                                     const Icon(Icons.delete, color: Colors.red),
//                                 onPressed: () =>
//                                     removeFromCart(item["courseId"]),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: const [
//                           BoxShadow(color: Colors.black12, blurRadius: 5),
//                         ],
//                         borderRadius: BorderRadius.circular(15),
//                       ),
                      
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // ✅ Phone Number Input (Shows Black Border When Focused)
//                           TextField(
//                             controller: phoneNumberController,
//                             decoration: InputDecoration(
//                               labelText: "Phone Number",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                     color:
//                                         Colors.black), // Default Black Border
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                     color: Colors.black,
//                                     width: 2), // Black Border on Focus
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 10),

//                           // ✅ Payment Method Dropdown (Same Styling as TextField)
//                           DropdownButtonFormField<String>(
//                             value: paymentMethod,
//                             decoration: InputDecoration(
//                               labelText: "Payment Method",
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                     color:
//                                         Colors.black), // Default Black Border
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                     color: Colors.black,
//                                     width: 2), // Black Border on Focus
//                               ),
//                             ),
//                             items: ["Card Payment", "PayPal"]
//                                 .map((method) => DropdownMenuItem(
//                                       value: method,
//                                       child: Text(method),
//                                     ))
//                                 .toList(),
//                             onChanged: (value) {
//                               setState(() {
//                                 paymentMethod = value!;
//                               });
//                             },
//                           ),
//                           const SizedBox(height: 15),

//                           // ✅ Total Price
//                           Text(
//                             "Total: \$${totalPrice.toStringAsFixed(2)}",
//                             style: const TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),

//                           const SizedBox(height: 15),

//                           // ✅ Checkout & Clear Cart Buttons (Same as CartPage)
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               OutlinedButton(
//                                 onPressed: clearCart,
//                                 style: OutlinedButton.styleFrom(
//                                   side: const BorderSide(
//                                       color: Colors.black), // Black Border
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 25, vertical: 12),
//                                 ),
//                                 child: const Text("Clear Cart",
//                                     style: TextStyle(color: Colors.black)),
//                               ),
//                               ElevatedButton(
//                                 onPressed: confirmOrder,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.black, // Black Button
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 25, vertical: 12),
//                                 ),
//                                 child: const Text("Place Order",
//                                     style: TextStyle(color: Colors.white)),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//     );
//   }
// }

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
