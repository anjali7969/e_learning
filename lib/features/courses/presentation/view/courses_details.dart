import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String courseId; // ✅ Add Course ID for API requests
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final String? videoUrl;

  const CourseDetailsScreen({
    super.key,
    required this.courseId, // ✅ Required for Cart API
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
  String? _userId; // ✅ Store User ID

  @override
  void initState() {
    super.initState();
    _selectedRating = widget.rating.round();

    _loadUserId(); // ✅ Fetch User ID

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

  /// **✅ Load User ID from SharedPreferences**
  Future<void> _loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('userId');
    });
  }

  /// **🛒 Add Course to Cart**
  Future<void> _addToCart() async {
    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("User not logged in!"), backgroundColor: Colors.red),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://localhost:5003/cart/add"), // ✅ Update API Endpoint
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": _userId,
          "courseId": widget.courseId,
          "quantity": 1, // ✅ Default quantity
        }),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${widget.title} added to cart successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception(
            responseData['message'] ?? "Failed to add course to cart");
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error"), backgroundColor: Colors.red),
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
