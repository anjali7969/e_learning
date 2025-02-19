// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
// automaticallyImplyLeading: false, // Removes the back arrow
// title: Align(
//   alignment:
//       Alignment.centerLeft, // Ensures logo is in the leftmost position
//   child: Image.asset(
//     'assets/images/logo.png',
//     height: 80,
//   ),
// ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.notifications, color: Colors.black),
//           ),
//           const SizedBox(width: 10),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start, // Left Align Content
//           children: [
//             const SizedBox(height: 10),

//             // Hero Section
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Up Your Skills\nTo Advance Your",
//                   style: TextStyle(
//                     fontSize: 33, // Keep the size bold and large
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     height:
//                         1.5, // Adjust line spacing (increase or decrease this value as needed)
//                   ),
//                 ),
//                 const SizedBox(height: 10), // Adjust space between text
//                 const Text(
//                   "Career Path",
//                   style: TextStyle(
//                     fontSize: 33,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 21, 135, 229),
//                     height: 1.0, // Adjust line spacing
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 const Text(
//                   "Learn skills with GateWay Education. \nThe latest online learning system and material that help your knowledge growing.",
//                   style: TextStyle(
//                     fontSize: 16, // Improved readability
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // Buttons
//                 Row(
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             const Color.fromARGB(255, 21, 135, 229),
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 14, horizontal: 24),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         "Get Started",
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     OutlinedButton(
//                       onPressed: () {},
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(color: Colors.blue),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 14, horizontal: 24),
//                       ),
//                       child: const Text(
//                         "Free Trial",
//                         style: TextStyle(fontSize: 16, color: Colors.black),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//             const SizedBox(height: 40),

//             // Statistics Section
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _statItem("2K+", "Video Courses"),
//                 _statItem("5K+", "Online Courses"),
//                 _statItem("250+", "Tutors"),
//               ],
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _statItem(String value, String label) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: const TextStyle(
//               fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 16, color: Colors.black87),
//         ),
//       ],
//     );
//   }
// }

import 'package:e_learning/app/di/di.dart';
import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IAuthRepository _authRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = getIt<IAuthRepository>(); // Inject Auth Repository
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes the back arrow
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20), // Adjust left padding as needed
            child: Image.asset(
              'assets/images/logo.png',
              height: 90,
            ),
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 10), // Adjust the right padding to move it left
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border,
                  color: Colors.black), // Wishlist Icon
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Title
            const Text(
              "What would you like to learn today?",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 15),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search for...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Discount Banner
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "25% OFF",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Today's Special\nGet a Discount for Every Course Order Only Valid for Today!",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Categories Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("SEE ALL"),
                ),
              ],
            ),

            // Horizontal Scroll for Categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _categoryItem("3D Design"),
                  _categoryItem("Arts & Humanities"),
                  _categoryItem("Graphic Design"),
                  _categoryItem("Programming"),
                  _categoryItem("Marketing"),
                  _categoryItem("Photography"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Popular Courses Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Popular Courses",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("SEE ALL"),
                ),
              ],
            ),
            Row(
              children: [
                _courseItem("Graphic Design Advanced", "850/-", "4.2 ⭐"),
                _courseItem("Advertisement & Branding", "400/-", "4.5 ⭐"),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _categoryItem(String name) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Chip(
        label: Text(name),
        backgroundColor: Colors.blue.shade50,
      ),
    );
  }

  Widget _courseItem(String title, String price, String rating) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.grey.shade300, // Placeholder for course image
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                price,
                style: const TextStyle(fontSize: 14, color: Colors.blue),
              ),
              Text(
                rating,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
