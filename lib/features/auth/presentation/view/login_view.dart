// import 'package:dio/dio.dart';
// import 'package:e_learning/features/auth/presentation/view/register_view.dart';
// import 'package:e_learning/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_navigation_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/common/snackbar/my_snackbar.dart';
// import '../../../../core/network/api_service.dart';

// class LoginView extends StatelessWidget {
//   LoginView({super.key});

//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   // Login Function
//   void login(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       final email = _emailController.text.trim();
//       final password = _passwordController.text.trim();

//       try {
//         final apiService = ApiService(Dio());
//         final user = await apiService.loginUser(email, password);

//         if (user != null && user['success'] == true) {
//           print("Login successful: $user");

//           // Show only ONE snackbar before navigation
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Login Successfully!'),
//               backgroundColor: Colors.green,
//             ),
//           );

//           // Ensure navigation happens only once
//           Future.delayed(const Duration(seconds: 1), () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const BottomNavigationView(),
//               ),
//             );
//           });
//         } else {
//           print("Invalid login response: $user");
//           showMySnackBar(
//             context: context,
//             message: 'Invalid username or password',
//             color: Colors.red,
//           );
//         }
//       } catch (e) {
//         print("Error during login: $e");
//         showMySnackBar(
//           context: context,
//           message: 'An error occurred. Please try again.',
//           color: Colors.red,
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Gradient Background
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFF81D4FA), // Light blue
//                   Color(0xFFFFFFFF), // White
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           SafeArea(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 50),
//                     Image.asset(
//                       'assets/images/logo.png',
//                       height: 150,
//                     ),
//                     const Text(
//                       'SIGN IN',
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 2, 2, 2),
//                         fontFamily: 'Rockwell',
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           // Email Input
//                           TextFormField(
//                             key: const Key('email'),
//                             controller: _emailController,
//                             decoration: InputDecoration(
//                               labelText: 'Email',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               hintText: 'Enter Your Email',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your email';
//                               }
//                               final emailRegex = RegExp(
//                                   r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
//                               if (!emailRegex.hasMatch(value.trim())) {
//                                 return "Enter a valid email address";
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 20),

//                           // Password Input
//                           TextFormField(
//                             key: const Key('password'),
//                             controller: _passwordController,
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               labelText: 'Password',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               hintText: 'Enter Your Password',
//                               suffixIcon: const Icon(Icons.visibility_off),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.length < 8) {
//                                 return 'Password must be at least 8 characters';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 10),

//                           // Forgot Password link
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton(
//                               onPressed: () {},
//                               child: const Text(
//                                 'Forgot Password?',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),

//                           // Login Button with Gradient
//                           Container(
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 colors: [Colors.black, Colors.blue],
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 // Show success Snackbar before navigating
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('Login Successfully!'),
//                                     backgroundColor: Colors.green,
//                                   ),
//                                 );

//                                 // Call login function
//                                 login(context);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.transparent,
//                                 shadowColor: Colors.transparent,
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 15, horizontal: 70),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                               ),
//                               child: const Text(
//                                 key: Key('loginButton'),
//                                 'Sign In',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                   fontFamily: "Rockwell",
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Divider
//                     const Row(
//                       children: [
//                         Expanded(
//                             child: Divider(thickness: 1, color: Colors.grey)),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Text(
//                             "OR",
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                             child: Divider(thickness: 1, color: Colors.grey)),
//                       ],
//                     ),
//                     const SizedBox(height: 40),

//                     // Sign Up prompt with underline
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Don’t have an account? "),
//                         TextButton(
//                           onPressed: () {
//                             context.read<LoginBloc>().add(
//                                   NavigateRegisterScreenEvent(
//                                     context: context,
//                                     destination: const RegisterView(),
//                                   ),
//                                 );
//                           },
//                           child: const Text(
//                             "Sign Up",
//                             style: TextStyle(
//                               color: Color(0xFF3579FF),
//                               fontFamily: 'Rockwell',
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:e_learning/app/di/di.dart';
import 'package:e_learning/features/auth/domain/usecases/login_student_usecase.dart';
import 'package:e_learning/features/auth/presentation/view/register_view.dart';
import 'package:e_learning/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:e_learning/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../../core/network/api_service.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'dj@gmail.com');
  final _passwordController = TextEditingController(text: '12345678');

  // Login Function
  void login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      try {
        final apiService = ApiService(Dio());
        final user = await apiService.loginUser(email, password);

        if (user != null && user['success'] == true) {
          print("Login successful: $user");

          // Show only ONE snackbar before navigation
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Successfully!'),
              backgroundColor: Colors.green,
            ),
          );

          // Ensure navigation happens only once
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavigationView(),
              ),
            );
          });
        } else {
          print("Invalid login response: $user");
          showMySnackBar(
            context: context,
            message: 'Invalid username or password',
            color: Colors.red,
          );
        }
      } catch (e) {
        print("Error during login: $e");
        showMySnackBar(
          context: context,
          message: 'An error occurred. Please try again.',
          color: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            registerBloc: context.read<RegisterBloc>(), // Get from context
            loginStudentUseCase: getIt<LoginStudentUsecase>(), // Get from DI
          ),
        ),
        // Ensuring LoginBloc is provided
      ],
      child: Scaffold(
        body: Stack(
          children: [
            // Gradient Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF81D4FA), // Light blue
                    Color(0xFFFFFFFF), // White
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 170,
                      ),
                      const Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 2, 2, 2),
                          fontFamily: 'Rockwell',
                        ),
                      ),
                      const SizedBox(height: 20),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email Input
                            TextFormField(
                              key: const Key('email'),
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Enter Your Email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                final emailRegex = RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                                if (!emailRegex.hasMatch(value.trim())) {
                                  return "Enter a valid email address";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Password Input
                            TextFormField(
                              key: const Key('password'),
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Enter Your Password',
                                suffixIcon: const Icon(Icons.visibility_off),
                              ),
                              validator: (value) {
                                if (value == null || value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),

                            // Forgot Password link
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Login Button with Gradient
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.black, Colors.blue],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Show success Snackbar before navigating
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Login Successfully!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );

                                  // Call login function
                                  login(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 70),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: const Text(
                                  key: Key('loginButton'),
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: "Rockwell",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Divider
                      const Row(
                        children: [
                          Expanded(
                              child: Divider(thickness: 1, color: Colors.grey)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "OR",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Divider(thickness: 1, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Sign Up prompt with underline
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don’t have an account? "),
                          TextButton(
                            onPressed: () {
                              context.read<LoginBloc>().add(
                                    NavigateRegisterScreenEvent(
                                      context: context,
                                      destination: const RegisterView(),
                                    ),
                                  );
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xFF3579FF),
                                fontFamily: 'Rockwell',
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
