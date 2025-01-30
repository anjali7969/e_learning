// import 'package:e_learning/app/di/di.dart';
// import 'package:e_learning/features/auth/presentation/view/login_view.dart';
// import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class RegisterView extends StatefulWidget {
//   const RegisterView({super.key});

//   @override
//   _RegisterViewState createState() => _RegisterViewState();
// }

// class _RegisterViewState extends State<RegisterView> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool _isPasswordVisible = false;

//   void _registerUser() {
//     if (_formKey.currentState!.validate()) {
//       context.read<RegisterBloc>().add(
//             RegisterUser(
//               context: context,
//               name: nameController.text,
//               email: emailController.text,
//               phone: phoneController.text,
//               password: passwordController.text,
//             ),
//           );

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Registered Successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           getIt<RegisterBloc>(), // Ensures RegisterBloc is available
//       child: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFF81D4FA), // Light blue
//                 Color(0xFFFFFFFF), // White
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 50),

//                   // Logo
//                   Image.asset(
//                     'assets/images/logo.png',
//                     height: 150,
//                   ),
//                   const SizedBox(height: 20),

//                   // Title
//                   const Text(
//                     'SIGN UP',
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontFamily: 'Poppins',
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   // Subtitle
//                   const Text(
//                     'Create your account to embark on your \neducational adventure',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontFamily: 'Poppins',
//                       color: Colors.black54,
//                     ),
//                   ),
//                   const SizedBox(height: 30),

//                   // Form Fields
//                   _buildTextField(nameController, "Your Name",
//                       "Enter your name", Icons.person),
//                   const SizedBox(height: 20),
//                   _buildTextField(emailController, "Your Email",
//                       "Enter your email", Icons.email),
//                   const SizedBox(height: 20),
//                   _buildTextField(phoneController, "Phone Number",
//                       "Enter your phone number", Icons.phone),
//                   const SizedBox(height: 20),
//                   _buildPasswordField(),
//                   const SizedBox(height: 30),

//                   SizedBox(
//                     width: double.infinity,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Colors.black, Colors.blue], // Gradient Color
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                         ),
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: ElevatedButton(
//                         onPressed: _registerUser,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors
//                               .transparent, // Transparent to show gradient
//                           shadowColor: Colors.transparent, // No extra shadow
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(
//                                 8.0), // Match border radius
//                           ),
//                         ),
//                         child: const Text(
//                           'SIGN UP',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                             fontFamily: "Rockwell",
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Already have an account?",
//                           style: TextStyle(fontFamily: 'Rockwell')),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const LoginPage()),
//                           );
//                         },
//                         child: const Text(
//                           "Sign In",
//                           style: TextStyle(
//                             color: Color(0xFF3579FF),
//                             fontFamily: 'Rockwell',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String labelText,
//       String hintText, IconData icon) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, size: 18, color: Colors.black),
//         labelText: labelText,
//         labelStyle: const TextStyle(color: Colors.black),
//         hintText: hintText,
//         hintStyle: const TextStyle(color: Colors.black54),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.black),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.black),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.black),
//         ),
//         filled: true,
//         fillColor: Colors.transparent,
//       ),
//       style: const TextStyle(color: Colors.black),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter $labelText';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildPasswordField() {
//     return TextFormField(
//       controller: passwordController,
//       obscureText: !_isPasswordVisible,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(Icons.lock, size: 18, color: Colors.black),
//         labelText: "Password",
//         labelStyle: const TextStyle(color: Colors.black),
//         hintText: "Enter your password",
//         hintStyle: const TextStyle(color: Colors.black54),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.black),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.black),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: const BorderSide(color: Colors.black),
//         ),
//         filled: true,
//         fillColor: Colors.transparent,
//         suffixIcon: IconButton(
//           icon: Icon(
//             _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             setState(() {
//               _isPasswordVisible = !_isPasswordVisible;
//             });
//           },
//         ),
//       ),
//       style: const TextStyle(color: Colors.black),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter password';
//         } else if (value.length < 8) {
//           return 'Password must be at least 8 characters long';
//         }
//         return null;
//       },
//     );
//   }
// }

import 'dart:io';

import 'package:e_learning/app/di/di.dart'; // Ensure dependency injection
import 'package:e_learning/features/auth/presentation/view/login_view.dart';
import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>(); // ✅ Fixed Variable Name
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _gap = const SizedBox(height: 8);

  final bool _isPasswordVisible = false;

  // Check camera permission
  Future<void> _checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  // Image variables
  File? _img;

  // Browse image from gallery or camera
  Future<void> _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          // Send image to RegisterBloc
          context.read<RegisterBloc>().add(LoadImage(file: _img!));
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterBloc>(), // Dependency injection fix
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF81D4FA),
                Color(0xFFFFFFFF)
              ], // Light blue to white
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // Logo
                  // Image.asset('assets/images/logo.png', height: 150),
                  // const SizedBox(height: 20),

                  // Profile Image Selection
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.grey[300],
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  _checkCameraPermission();
                                  _browseImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _browseImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.image),
                                label: const Text('Gallery'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _img != null
                            ? FileImage(_img!)
                            : const AssetImage('assets/images/profile.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // // Title
                  // const Text(
                  //   'SIGN UP',
                  //   style: TextStyle(
                  //     fontSize: 30,
                  //     fontFamily: 'Poppins',
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //   ),
                  // ),
                  // const SizedBox(height: 10),

                  // // Subtitle
                  // const Text(
                  //   'Create your account to embark on your \neducational adventure',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //       fontSize: 14,
                  //       fontFamily: 'Poppins',
                  //       color: Colors.black54),
                  // ),
                  // const SizedBox(height: 30),

                  // Form Fields
                  _buildTextField(nameController, "Your Name",
                      "Enter your name", Icons.person),
                  const SizedBox(height: 20),
                  _buildTextField(emailController, "Your Email",
                      "Enter your email", Icons.email),
                  const SizedBox(height: 20),
                  _buildTextField(phoneController, "Phone Number",
                      "Enter your phone number", Icons.phone),
                  const SizedBox(height: 20),
                  _buildPasswordField(),
                  const SizedBox(height: 30),

                  // Sign Up Button
                  _gap,
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.black, Colors.blue], // Gradient Color
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        // style: ElevatedButton.styleFrom(
                        //   backgroundColor: Colors.transparent,
                        //   shadowColor: Colors.transparent,
                        //   padding: const EdgeInsets.symmetric(vertical: 15),
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(8.0),
                        //   ),
                        // ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final registerState =
                                context.read<RegisterBloc>().state;
                            final imageName = registerState.imageName;
                            context.read<RegisterBloc>().add(
                                  RegisterUser(
                                    context: context,
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                    image: imageName,
                                  ),
                                );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registered Successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "Rockwell",
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?",
                          style: TextStyle(fontFamily: 'Rockwell')),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginView()),
                          );
                        },
                        child: const Text("Sign In",
                            style: TextStyle(
                                color: Color(0xFF3579FF),
                                fontFamily: 'Rockwell',
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      String hintText, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, size: 18, color: Colors.black),
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter $labelText' : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: !_isPasswordVisible,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock, size: 18, color: Colors.black),
        labelText: "Password",
      ),
    );
  }
}
