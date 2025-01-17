// import 'package:flutter/material.dart';

// class EditProfileScreen extends StatelessWidget {
//   const EditProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         backgroundColor: const Color(0xFF0A3D62), // Dark blue
//         title: const Text(
//           "Edit Profile",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _buildTextField(label: "Bio", hintText: "Enter your bio"),
//             _buildTextField(label: "Gender", hintText: "Female"),
//             _buildTextField(label: "Address", hintText: "Dhaneshwor, Gongabu"),
//             _buildTextField(label: "City", hintText: "Kathmandu"),
//             _buildTextField(label: "Province/State", hintText: "Province 3"),
//             _buildTextField(
//                 label: "School", hintText: "Jalupa Secondary School"),
//             _buildTextField(label: "College", hintText: "Uniglobe SS College"),
//             _buildTextField(label: "Background", hintText: "Management"),
//             _buildTextField(label: "Contact Number", hintText: "9808115910"),
//             _buildTextField(
//                 label: "Parents Contact Number", hintText: "9823232835"),
//             _buildTextField(label: "Parents First Name", hintText: "Apsara"),
//             _buildTextField(label: "Parents Last Name", hintText: "Shrestha"),
//             _buildTextField(
//                 label: "Parents Email Address",
//                 hintText: "Enter email address"),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                   child: const Text("Cancel"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Save profile changes
//                   },
//                   child: const Text("Update"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({required String label, required String hintText}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             ),
//           ),
//           const SizedBox(height: 4),
//           TextField(
//             decoration: InputDecoration(
//               hintText: hintText,
//               prefixIcon: const Icon(Icons.person),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
