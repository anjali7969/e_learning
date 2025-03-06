// import 'package:e_learning/features/auth/presentation/view/login_view.dart';
// import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_view/edit_profile_screen.dart';
// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 90, // Increased AppBar height
//         backgroundColor: Colors.white, // Consistent dark blue
//         title: Row(
//           children: [
//             // Wrapping the logo with Expanded to handle overflow
//             Expanded(
//               child: Image.asset(
//                 'assets/images/logo.png',
//                 height: 50, // Adjusted logo size
//                 fit: BoxFit.contain, // Ensure the logo doesn't get stretched
//               ),
//             ),
//             const SizedBox(width: 10),
//             const Text(
//               "", // Empty Text, can be added if needed
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         centerTitle: false, // Title aligned left with logo
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           // User Info Card
//           Card(
//             elevation: 4,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const CircleAvatar(
//                     radius: 40,
//                     backgroundImage: AssetImage(
//                         'assets/images/user_photo.png'), // Replace with user photo
//                   ),
//                   const SizedBox(width: 16),
//                   const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Anjali Shrestha",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           "softwarica",
//                           style: TextStyle(fontSize: 14, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const EditProfileScreen(),
//                         ),
//                       );
//                     },
//                     icon: const Icon(
//                       Icons.edit,
//                       color: Color(0xFF0A3D62),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),

//           // Profile Options
//           const _ProfileOption(
//             icon: Icons.person,
//             title: "Edit Profile",
//             subtitle: "Edit your information",
//           ),
//           const _ProfileOption(
//             icon: Icons.description,
//             title: "My Documents",
//             subtitle: "View your documents",
//           ),
//           const _ProfileOption(
//             icon: Icons.task,
//             title: "Tasks",
//             subtitle: "View tasks for each week",
//           ),
//           const _ProfileOption(
//             icon: Icons.timeline,
//             title: "My Journey",
//             subtitle: "View your progress of each module",
//           ),
//           const _ProfileOption(
//             icon: Icons.book,
//             title: "Books",
//             subtitle: "Books you requested to borrow",
//           ),
//           const _ProfileOption(
//             icon: Icons.book_outlined,
//             title: "My Journals",
//             subtitle: "Add or view your journal",
//           ),
//           const _ProfileOption(
//             icon: Icons.support_agent,
//             title: "Support Staffs",
//             subtitle: "Request here to get support",
//           ),
//           const _ProfileOption(
//             icon: Icons.settings,
//             title: "Settings",
//             subtitle: "Update password and details here",
//           ),

//           // Logout Option
//           ListTile(
//             leading: const Icon(
//               Icons.logout,
//               color: Colors.red,
//               size: 30,
//             ),
//             title: const Text(
//               "Logout",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             subtitle: const Text("Logout your account from device"),
//             onTap: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const LoginView(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ProfileOption extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;

//   const _ProfileOption({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: const Color(0xFF0A3D62), // Dark blue
//         size: 30,
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(fontWeight: FontWeight.bold),
//       ),
//       subtitle: Text(subtitle),
//       onTap: () {
//         // Add navigation or functionality here
//       },
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userId, userName, userEmail, userPhone, profileImage, userToken;
  bool isLoading = true;
  List<dynamic> userOrders = []; // ✅ Store user orders
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// **✅ Load User ID & Token from SharedPreferences**
  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? "";
      userToken = prefs.getString('token') ?? "";
    });

    if (userId!.isNotEmpty && userToken!.isNotEmpty) {
      _fetchUserProfile();
      _fetchUserOrders(); // ✅ Fetch user orders
    } else {
      setState(() {
        isLoading = false;
      });
      _showSnackBar("User not logged in. Please login again.", Colors.red);
    }
  }

  /// **✅ Fetch User Profile**
  Future<void> _fetchUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse("http://10.0.2.2:5003/user/$userId"),
        headers: {"Authorization": "Bearer $userToken"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userName = data["user"]["name"] ?? "Unknown";
          userEmail = data["user"]["email"] ?? "No Email";
          userPhone = data["user"]["phone"] ?? "Not Set";
          profileImage = data["user"]["profilePicture"];
          isLoading = false;
        });
      } else {
        throw Exception("Failed to fetch user data.");
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _showSnackBar("Error: $error", Colors.red);
    }
  }

  /// **✅ Fetch User Orders**
  Future<void> _fetchUserOrders() async {
    try {
      final response = await http.get(
        Uri.parse("http://10.0.2.2:5003/order/my-orders"),
        headers: {"Authorization": "Bearer $userToken"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          userOrders = data;
        });
      } else {
        throw Exception("Failed to fetch user orders.");
      }
    } catch (error) {
      print("❌ Error fetching orders: $error");
    }
  }

  /// **✅ Update User Profile (Fixing Undefined Error)**
  Future<void> _updateUserProfile(
      String updatedName, String updatedPhone) async {
    if (userId == null || userId!.isEmpty) return;

    try {
      final response = await http.put(
        Uri.parse("http://10.0.2.2:5003/user/update/$userId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $userToken"
        },
        body: jsonEncode({"name": updatedName, "phone": updatedPhone}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', updatedName);
        await prefs.setString('userPhone', updatedPhone);

        setState(() {
          userName = updatedName;
          userPhone = updatedPhone;
        });

        _showSnackBar(
            responseData["message"] ?? "Profile updated!", Colors.green);
      } else {
        throw Exception(responseData["error"] ?? "Failed to update profile");
      }
    } catch (error) {
      _showSnackBar("Error: $error", Colors.red);
    }
  }

  /// **✅ Upload Profile Picture**
  Future<void> _uploadProfilePicture() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("http://10.0.2.2:5003/user/uploadImage"),
      );
      request.headers["Authorization"] = "Bearer $userToken";
      request.files
          .add(await http.MultipartFile.fromPath('file', pickedFile.path));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseData);
        setState(() {
          profileImage = jsonResponse["filePath"];
        });

        _showSnackBar("Profile picture updated!", Colors.green);
      } else {
        throw Exception("Failed to upload profile picture.");
      }
    } catch (error) {
      _showSnackBar("Error: $error", Colors.red);
    }
  }

  /// **✅ Show Edit Dialog**
  void _showEditDialog(
      String title, String fieldValue, Function(String) onSave) {
    final TextEditingController controller =
        TextEditingController(text: fieldValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $title"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: "Enter new $title"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  /// **✅ Show Snackbar**
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  /// **✅ Logout Function**
  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _showSnackBar("Logged out successfully", Colors.blue);
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800, // Changed from purple to black
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // **Profile Picture**
                  GestureDetector(
                    onTap: _uploadProfilePicture,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage:
                          profileImage != null && profileImage!.isNotEmpty
                              ? NetworkImage(profileImage!)
                              : const AssetImage(
                                      "assets/images/profile-picture.jpg")
                                  as ImageProvider,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // **User Info Section**
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 2)
                      ],
                    ),
                    child: Column(
                      children: [
                        // **User Name**
                        ListTile(
                          leading:
                              const Icon(Icons.person, color: Colors.black),
                          title: const Text("Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          subtitle: Text(userName ?? "Not Set",
                              style: const TextStyle(fontSize: 14)),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.black),
                            onPressed: () {
                              _showEditDialog("Name", userName ?? "",
                                  (newName) {
                                _updateUserProfile(newName, userPhone ?? "");
                              });
                            },
                          ),
                        ),
                        const Divider(thickness: 1),

                        // **Phone Number**
                        ListTile(
                          leading: const Icon(Icons.phone, color: Colors.black),
                          title: const Text("Phone Number",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          subtitle: Text(userPhone ?? "Not Set",
                              style: const TextStyle(fontSize: 14)),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.black),
                            onPressed: () {
                              _showEditDialog("Phone Number", userPhone ?? "",
                                  (newPhone) {
                                _updateUserProfile(userName ?? "", newPhone);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // **Orders Section**
                  const Text("My Orders",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  userOrders.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ],
                          ),
                          child: const Center(
                            child: Text("No orders placed yet.",
                                style: TextStyle(fontSize: 14)),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: userOrders.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                    "Order ID: ${userOrders[index]['_id']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
    );
  }
}
