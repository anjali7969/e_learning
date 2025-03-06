import 'dart:convert';

import 'package:e_learning/app/di/di.dart';
import 'package:e_learning/app/shared_prefs/token_shared_prefs.dart';
import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';
import 'package:e_learning/features/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IAuthRepository _authRepository;
  List<dynamic> popularCourses = [];
  bool isLoading = true;
  bool showAllCourses = false; // Toggle for "SEE ALL" and "SHOW LESS"

  @override
  void initState() {
    super.initState();
    _authRepository = getIt<IAuthRepository>();
    fetchCourses();
  }

  // ✅ Fetch Courses from Backend
  Future<void> fetchCourses() async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:5003/courses/all"));

      if (response.statusCode == 200) {
        List<dynamic> courses = json.decode(response.body);
        setState(() {
          popularCourses = courses.take(5).toList(); // Take first 5 courses
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load courses");
      }
    } catch (e) {
      print("Error fetching courses: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void logoutUser(BuildContext context) async {
    // ✅ Clear Authentication Token (But NOT Onboarding Preference)
    await getIt<TokenSharedPrefs>().clearToken();

    // ✅ Navigate Directly to Login Page (Onboarding Preference Stays)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
  }

  // ✅ Get Image URL
  String getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return "https://via.placeholder.com/150"; // Placeholder image
    }
    return "http://10.0.2.2:5003${imagePath.trim()}"; // Full URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // ✅ Title
            const Text(
              "What would you like to learn today?",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 15),

            // ✅ Search Bar
            _buildSearchBar(),

            const SizedBox(height: 20),

            // ✅ Discount Banner
            _buildDiscountBanner(),

            const SizedBox(height: 20),

            // ✅ Categories Section
            _buildSectionHeader("Categories"),

            // ✅ Categories Horizontal Scroll
            _buildCategories(),

            const SizedBox(height: 20),

            // ✅ Popular Courses Section
            _buildPopularCourses(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ✅ App Bar with Wishlist Icon
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset('assets/images/logo.png', height: 100),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () => logoutUser(context),
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ),
      ],
    );
  }

  // ✅ Search Bar Widget
  Widget _buildSearchBar() {
    return TextField(
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
    );
  }

  // ✅ Discount Banner
  Widget _buildDiscountBanner() {
    return Container(
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
    );
  }

  // ✅ Section Header
  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              showAllCourses = !showAllCourses; // Toggle between show/hide
            });
          },
          child: Text(showAllCourses ? "SHOW LESS" : "SEE ALL"),
        ),
      ],
    );
  }

  // ✅ Categories List
  Widget _buildCategories() {
    return SingleChildScrollView(
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
    );
  }

  // ✅ Category Item
  Widget _categoryItem(String name) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Chip(
        label: Text(name),
        backgroundColor: Colors.blue.shade50,
      ),
    );
  }

  // ✅ Popular Courses Section (GRID VIEW)
  Widget _buildPopularCourses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Popular Courses"),
        const SizedBox(height: 10),
        isLoading
            ? const Center(
                child: CircularProgressIndicator()) // Show loading state
            : GridView.builder(
                shrinkWrap: true,
                physics: showAllCourses
                    ? const ScrollPhysics() // Enable scrolling when expanded
                    : const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // ✅ Two courses per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75, // ✅ Adjusted for better layout
                ),
                itemCount: showAllCourses
                    ? popularCourses.length
                    : 2, // Show only 2 initially
                itemBuilder: (context, index) {
                  return _courseItem(popularCourses[index]);
                },
              ),
      ],
    );
  }

  // ✅ Course Card (Dynamically Loaded)
  Widget _courseItem(dynamic course) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                getImageUrl(course["image"]),
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(course["title"] ?? "No title"),
            // 💰 Price
            Text(
              "${course["price"] ?? "N/A"}/-",
              style: const TextStyle(fontSize: 14, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}











// import 'dart:convert';

// import 'package:e_learning/app/constants/api_endpoints.dart';
// import 'package:e_learning/app/di/di.dart';
// import 'package:e_learning/app/shared_prefs/token_shared_prefs.dart';
// import 'package:e_learning/features/auth/domain/repository/auth_repository.dart';
// import 'package:e_learning/features/auth/presentation/view/login_view.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late IAuthRepository _authRepository;
//   List<dynamic> popularCourses = [];
//   bool isLoading = true;
//   bool showAllCourses = false;

//   // // Shake detection variables
//   // double shakeThreshold = 15.0;
//   // int shakeCount = 0;
//   // DateTime? lastShakeTime;

//   @override
//   void initState() {
//     super.initState();
//     _authRepository = getIt<IAuthRepository>();
//     fetchCourses();
//     // _startShakeDetection();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   /// ✅ Shake Detection Logic
//   // void _startShakeDetection() {
//   //   accelerometerEvents.listen((AccelerometerEvent event) {
//   //     double acceleration =
//   //         (event.x * event.x) + (event.y * event.y) + (event.z * event.z);

//   //     if (acceleration > shakeThreshold) {
//   //       DateTime now = DateTime.now();
//   //       if (lastShakeTime == null ||
//   //           now.difference(lastShakeTime!) > const Duration(seconds: 1)) {
//   //         shakeCount++;
//   //         lastShakeTime = now;
//   //       }

//   //       if (shakeCount >= 3) {
//   //         // Logout after 3 shakes
//   //         _logoutUser(context);
//   //         shakeCount = 0;
//   //       }
//   //     }
//   //   });
//   // }

//   /// ✅ Logout User on Shake
//   void _logoutUser(BuildContext context) async {
//     print("🔄 Logging out...");
//     await getIt<TokenSharedPrefs>().clearToken();

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginView()),
//     );
//   }

//   /// ✅ Fetch Courses from Backend
//   Future<void> fetchCourses() async {
//     try {
//       final response =
//           await http.get(Uri.parse("http://10.0.2.2:5003/courses/all"));

//       if (response.statusCode == 200) {
//         List<dynamic> courses = json.decode(response.body);
//         setState(() {
//           popularCourses = courses.take(5).toList();
//           isLoading = false;
//         });
//       } else {
//         throw Exception("Failed to load courses");
//       }
//     } catch (e) {
//       print("Error fetching courses: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildAppBar(),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             const Text(
//               "What would you like to learn today?",
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//             const SizedBox(height: 15),
//             _buildSearchBar(),
//             const SizedBox(height: 20),
//             _buildDiscountBanner(),
//             const SizedBox(height: 20),
//             _buildSectionHeader("Categories"),
//             _buildCategories(),
//             const SizedBox(height: 20),
//             _buildPopularCourses(),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ✅ App Bar
//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       automaticallyImplyLeading: false,
//       title: Align(
//         alignment: Alignment.centerLeft,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: Image.asset('assets/images/logo.png', height: 100),
//         ),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 10),
//           child: IconButton(
//             onPressed: () => _logoutUser(context),
//             icon: const Icon(Icons.logout, color: Colors.black),
//           ),
//         ),
//       ],
//     );
//   }

//   /// ✅ Search Bar
//   Widget _buildSearchBar() {
//     return TextField(
//       decoration: InputDecoration(
//         hintText: "Search for...",
//         prefixIcon: const Icon(Icons.search),
//         suffixIcon: IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.filter_list),
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }

//   /// ✅ Discount Banner
//   Widget _buildDiscountBanner() {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade700,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "25% OFF",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 5),
//           Text(
//             "Today's Special\nGet a Discount for Every Course Order Only Valid for Today!",
//             style: TextStyle(fontSize: 14, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ✅ Section Header
//   Widget _buildSectionHeader(String title) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         TextButton(
//           onPressed: () {
//             setState(() {
//               showAllCourses = !showAllCourses;
//             });
//           },
//           child: Text(showAllCourses ? "SHOW LESS" : "SEE ALL"),
//         ),
//       ],
//     );
//   }

//   /// ✅ Categories List
//   Widget _buildCategories() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           _categoryItem("3D Design"),
//           _categoryItem("Arts & Humanities"),
//           _categoryItem("Graphic Design"),
//           _categoryItem("Programming"),
//           _categoryItem("Marketing"),
//           _categoryItem("Photography"),
//         ],
//       ),
//     );
//   }

//   /// ✅ Category Item
//   Widget _categoryItem(String name) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10),
//       child: Chip(
//         label: Text(name),
//         backgroundColor: Colors.blue.shade50,
//       ),
//     );
//   }

//   /// ✅ Popular Courses Section (GRID VIEW)
//   Widget _buildPopularCourses() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionHeader("Popular Courses"),
//         const SizedBox(height: 10),
//         isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : GridView.builder(
//                 shrinkWrap: true,
//                 physics: showAllCourses
//                     ? const ScrollPhysics()
//                     : const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 0.75,
//                 ),
//                 itemCount: showAllCourses ? popularCourses.length : 2,
//                 itemBuilder: (context, index) {
//                   return _courseItem(popularCourses[index]);
//                 },
//               ),
//       ],
//     );
//   }

//   /// ✅ Course Card
//   Widget _courseItem(dynamic course) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ✅ Course Image with API Base URL
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10), // ✅ Rounded corners
//               child: Image.network(
//                 "${ApiEndpoints.photoUrl}${course["image"]}", // ✅ Concatenated URL
//                 height: 120, // ✅ Adjust height as needed
//                 width: double.infinity, // ✅ Ensures it fills the card width
//                 fit: BoxFit.cover, // ✅ Ensures proper scaling
//                 errorBuilder: (context, error, stackTrace) => const Icon(
//                   Icons.image_not_supported,
//                   size: 100,
//                   color: Colors.grey,
//                 ), // ✅ Fallback icon if image fails to load
//               ),
//             ),
//             const SizedBox(height: 10), // ✅ Space between image & text

//             // ✅ Course Title
//             Text(
//               course["title"] ?? "No title",
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),

//             const SizedBox(height: 5), // ✅ Space between title & price

//             // ✅ Course Price
//             Text(
//               "${course["price"] ?? "N/A"}/-",
//               style: const TextStyle(fontSize: 14, color: Colors.blue),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



