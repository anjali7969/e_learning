// import 'dart:io';

// import 'package:e_learning/app/di/di.dart'; // Ensure dependency injection
// import 'package:e_learning/features/auth/presentation/view/login_view.dart';
// import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

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
//   final _gap = const SizedBox(height: 8);

//   final bool _isPasswordVisible = false;

//   // Check camera permission
//   Future<void> _checkCameraPermission() async {
//     if (await Permission.camera.request().isRestricted ||
//         await Permission.camera.request().isDenied) {
//       await Permission.camera.request();
//     }
//   }

//   // Image variables
//   File? _img;

//   // Browse image from gallery or camera
//   Future<void> _browseImage(ImageSource imageSource) async {
//     try {
//       final image = await ImagePicker().pickImage(source: imageSource);
//       if (image != null) {
//         setState(() {
//           _img = File(image.path);
//           // Send image to RegisterBloc
//           context.read<RegisterBloc>().add(
//                 LoadImage(file: _img!),
//               );
//         });
//       } else {
//         return;
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<RegisterBloc>(), // Dependency injection fix
//       child: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFF81D4FA),
//                 Color(0xFFFFFFFF)
//               ], // Light blue to white
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

//                   // Profile Image Selection with Camera Icon
//                   Stack(
//                     alignment: Alignment.bottomRight,
//                     children: [
//                       CircleAvatar(
//                         radius: 75,
//                         backgroundImage: _img != null
//                             ? FileImage(_img!)
//                             : const AssetImage('assets/images/profile.png')
//                                 as ImageProvider,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           showModalBottomSheet(
//                             backgroundColor: Colors.grey[300],
//                             context: context,
//                             isScrollControlled: true,
//                             shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(20),
//                               ),
//                             ),
//                             builder: (context) => Padding(
//                               padding: const EdgeInsets.all(20),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   ElevatedButton.icon(
//                                     onPressed: () {
//                                       _checkCameraPermission();
//                                       _browseImage(ImageSource.camera);
//                                       Navigator.pop(context);
//                                     },
//                                     icon: const Icon(Icons.camera),
//                                     label: const Text('Camera'),
//                                   ),
//                                   ElevatedButton.icon(
//                                     onPressed: () {
//                                       _checkCameraPermission();
//                                       _browseImage(ImageSource.gallery);
//                                       Navigator.pop(context);
//                                     },
//                                     icon: const Icon(Icons.image),
//                                     label: const Text('Gallery'),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           decoration: const BoxDecoration(
//                             color: Colors.black,
//                             shape: BoxShape.circle,
//                           ),
//                           padding: const EdgeInsets.all(6),
//                           child: const Icon(
//                             Icons.camera_alt,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                     ],
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

//                   // Sign Up Button
//                   _gap,
//                   SizedBox(
//                     width: double.infinity,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [
//                             Colors.black,
//                             Colors.blue
//                           ], // 🔹 Gradient color here
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                         ),
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             final registerState =
//                                 context.read<RegisterBloc>().state;
//                             final imageName = registerState.imageName;
//                             context.read<RegisterBloc>().add(
//                                   RegisterUser(
//                                     context: context,
//                                     name: nameController.text,
//                                     email: emailController.text,
//                                     phone: phoneController.text,
//                                     password: passwordController.text,
//                                     image: imageName,
//                                   ),
//                                 );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors
//                               .transparent, // ✅ Make background transparent
//                           shadowColor: Colors
//                               .transparent, // ✅ Remove shadow to avoid overlay
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
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
//                                 builder: (context) => LoginView()),
//                           );
//                         },
//                         child: const Text("Sign In",
//                             style: TextStyle(
//                                 color: Color(0xFF3579FF),
//                                 fontFamily: 'Rockwell',
//                                 decoration: TextDecoration.underline)),
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
//         hintText: hintText,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter Your Name';
//         }
//         if (labelText == "Your Email" &&
//             !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//           return 'Enter a valid email';
//         }
//         if (labelText == "Phone Number" &&
//             !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//           return 'Enter a valid phone number';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildPasswordField() {
//     return TextFormField(
//       key: const Key('password'),
//       controller: passwordController,
//       obscureText: !_isPasswordVisible,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(Icons.lock, size: 18, color: Colors.black),
//         labelText: "Password",
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter password';
//         }
//         if (value.length < 8) {
//           return 'Password must be at least 8 characters';
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
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                getIt<RegisterBloc>()), // ✅ Fixes ProviderNotFoundException
      ],
      child: const RegisterViewBody(),
    );
  }
}

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  _RegisterViewBodyState createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _gap = const SizedBox(height: 8);
  final bool _isPasswordVisible = false;
  File? _img;

  Future<void> _checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          context.read<RegisterBloc>().add(LoadImage(file: _img!));
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF81D4FA), Color(0xFFFFFFFF)],
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

                // Profile Image Selection with Camera Icon
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundImage: _img != null
                          ? FileImage(_img!)
                          : const AssetImage('assets/images/profile.png')
                              as ImageProvider,
                    ),
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
                                    _checkCameraPermission();
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
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Title
                const Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),

                // Form Fields
                _buildTextField(nameController, "Your Name", "Enter your name",
                    Icons.person),
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
                        colors: [Colors.black, Colors.blue],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
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
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
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
                          MaterialPageRoute(builder: (context) => LoginView()),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Your Name';
        }
        if (labelText == "Your Email" &&
            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Enter a valid email';
        }
        if (labelText == "Phone Number" &&
            !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
          return 'Enter a valid phone number';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, size: 18, color: Colors.black),
        labelText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
