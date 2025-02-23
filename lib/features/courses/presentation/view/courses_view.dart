import 'dart:convert';

import 'package:e_learning/features/cart/presentation/view/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> allCourses = [];
  List<dynamic> filteredCourses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  // ✅ Fetch courses from the backend
  Future<void> fetchCourses() async {
    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:5003/courses/all"));

      if (response.statusCode == 200) {
        List<dynamic> courses = json.decode(response.body);
        setState(() {
          allCourses = courses;
          filteredCourses = courses;
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

  // ✅ Search courses
  void _filterCourses(String query) {
    setState(() {
      filteredCourses = allCourses
          .where((course) =>
              course["title"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  String getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.trim().isEmpty) {
      return "https://via.placeholder.com/150"; // Use placeholder if empty
    }

    // Ensure proper formatting by trimming spaces and adding correct prefix
    return "http://10.0.2.2:5003${imagePath.trim()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ Match background color
      appBar: AppBar(
        automaticallyImplyLeading: false, // ✅ Removes the back arrow
        backgroundColor: Colors.white, // ✅ Match navbar color
        elevation: 0, // ✅ Removes the shadow when scrolling
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/images/logo.png',
              height: 100,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                // Navigate to the cart screen when clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ShoppingCartScreen(userId: "USER_ID_HERE")),
                );
              },
              icon: const Icon(Icons.shopping_cart,
                  color: Colors.black), // ✅ Changed to Cart Icon
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search Bar
            TextField(
              controller: _searchController,
              onChanged: _filterCourses,
              decoration: InputDecoration(
                hintText: "Search courses...",
                prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // 📚 Course List or Loading Indicator
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator()) // Loading indicator
                  : filteredCourses.isEmpty
                      ? const Center(
                          child: Text(
                            "No courses found!",
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredCourses.length,
                          itemBuilder: (context, index) {
                            final course = filteredCourses[index];
                            return _buildCourseCard(course);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  // 🎨 Course Card UI
  Widget _buildCourseCard(dynamic course) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📷 Course Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                getImageUrl(course["image"]),
                width: 110,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  "assets/images/placeholder.png", // ✅ Local fallback image
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),

            // 📖 Course Details with `Expanded` to prevent overflow
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course["title"] ?? "No title",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis, // Prevents text overflow
                  ),
                  const SizedBox(height: 5),
                  Text(
                    course["description"] ?? "No description",
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                    maxLines: 2, // Limits lines to avoid overflow
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        _showCoursePopup(course);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        minimumSize: const Size(100, 35), // Prevents overflow
                      ),
                      child: const Text(
                        "Enroll Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📌 Show Popup in the Center for Course Details
  void _showCoursePopup(dynamic course) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start, // Left align text
            children: [
              // 📷 Course Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    getImageUrl(course["image"]),
                    width: 220,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                        "assets/images/placeholder.png",
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // 📖 Course Details
              Text(
                course["title"] ?? "No title",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                course["description"] ?? "No description",
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(height: 10),

              // 💰 Price
              Text(
                "Price: \$${course["price"] ?? "Not Available"}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // 🛒 Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement Buy Now
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      minimumSize: const Size(120, 40),
                    ),
                    child: const Text(
                      "Buy Now",
                      style: TextStyle(
                          color: Colors.white), // ✅ White text for "Buy Now"
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Implement Add to Cart
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(120, 40),
                    ),
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(
                          color:
                              Colors.black), // ✅ Black text for "Add to Cart"
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
