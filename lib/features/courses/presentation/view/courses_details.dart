import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String courseId;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final String? videoUrl;

  const CourseDetailsScreen({
    super.key,
    required this.courseId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    this.videoUrl,
  });

  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  int _selectedRating = 0;
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  String? _userId;
  String? _token; // 🔥 Store Auth Token

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.rating.round();

    _loadUserData(); // ✅ Fetch User Data

    if (widget.videoUrl != null && widget.videoUrl!.isNotEmpty) {
      _videoController = VideoPlayerController.network(widget.videoUrl!)
        ..initialize().then((_) {
          setState(() {
            _isVideoInitialized = true;
          });
        });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  /// **✅ Load User ID & Token from SharedPreferences**
  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedUserId = prefs.getString('userId');
    final storedToken = prefs.getString('token'); // 🔥 Fetch Token

    print("🟢 Stored User ID in SharedPreferences: $storedUserId");
    print("🟢 Stored Auth Token: $storedToken");

    setState(() {
      _userId = storedUserId;
      _token = storedToken; // ✅ Store token
    });
  }

  /// **🛒 Add Course to Cart with Authentication**
  Future<void> _addToCart() async {
    if (_userId == null || _token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User not logged in! Please log in first."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:5003/cart/add"), // ✅ Ensure Correct API URL
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token" // 🔥 Include Token for Auth
        },
        body: jsonEncode({
          "userId": _userId,
          "courseId": widget.courseId,
          "quantity": 1,
        }),
      );

      print("🟡 API Response Status: ${response.statusCode}");
      print("🟡 API Response Body: ${response.body}");

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${widget.title} added to cart successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        final responseData = jsonDecode(response.body);
        throw Exception(
            responseData['message'] ?? "Failed to add course to cart");
      }
    } catch (error) {
      print("❌ Error adding to cart: $error");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Course Details"), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📷 Course Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.imageUrl,
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      "assets/images/placeholder.png",
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 📖 Course Title
              Text(widget.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              // ⭐ Course Rating
              Row(
                children: List.generate(
                  5,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedRating = index + 1;
                      });
                    },
                    child: Icon(
                      Icons.star,
                      color:
                          index < _selectedRating ? Colors.orange : Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // 💵 Course Price
              Text("Price: \$${widget.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // 🎥 Video Section
              if (widget.videoUrl != null && widget.videoUrl!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Course Preview",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    _isVideoInitialized
                        ? AspectRatio(
                            aspectRatio: _videoController!.value.aspectRatio,
                            child: VideoPlayer(_videoController!),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 16),
                  ],
                ),

              // 📝 Course Description
              Text(widget.description, style: const TextStyle(fontSize: 16)),

              const SizedBox(height: 40),

              // 🛒 **ADD TO CART BUTTON**
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.black, Colors.blue],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _addToCart, // ✅ Call Add to Cart function
                  child: const Text(
                    "ADD TO CART",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: "Rockwell",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
