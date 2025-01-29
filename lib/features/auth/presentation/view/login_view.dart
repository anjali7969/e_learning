import 'package:e_learning/features/auth/presentation/view/register_view.dart';
import 'package:e_learning/features/bottom_navigation/presentation/view/bottom_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  bool _rememberMe = false;

  void login() async {
    var userBox = await Hive.openBox('users'); // Open Hive box
    String email = emailController.text;
    String password = passwordController.text;

    // Check if email exists in Hive storage
    if (userBox.containsKey(email)) {
      Map<String, dynamic> userData = userBox.get(email);
      if (userData["password"] == password) {
        _showSuccessSnackBar("Login successful!");

        // Navigate to Dashboard after showing success message
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavigationView()),
          );
        });
      } else {
        _showErrorSnackBar("Incorrect password. Try again.");
      }
    } else {
      _showErrorSnackBar("No account found with this email.");
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
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

          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),

                // Logo
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 180,
                  ),
                ),

                const SizedBox(height: 10),

                // Title
                const Center(
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Text after Sign In
                const Center(
                  child: Text(
                    'Sign in to access your personalized\n learning journey',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 20),
                // Email Input Field
                _buildTextField(
                  controller: emailController,
                  label: 'Email',
                  hintText: 'Enter your email',
                  errorText: _emailError,
                ),

                const SizedBox(height: 20),

                // Password Input Field
                _buildTextField(
                  controller: passwordController,
                  label: 'Password',
                  hintText: 'Enter your password',
                  isPassword: true,
                  errorText: _passwordError,
                ),

                const SizedBox(height: 20),

                // Remember Me and Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                        ),
                        const Text('Remember Me'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle forgot password logic here
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                // Sign In Button
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Perform validation before submitting
                      _validateForm();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.black, Colors.blue],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Center(
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // // Divider with "Sign in with"
                // const Row(
                //   children: [
                //     Expanded(child: Divider(color: Colors.grey)),
                //     Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 8.0),
                //       child: Text(
                //         'Sign in with',
                //         style: TextStyle(
                //           fontFamily: 'Poppins',
                //           color: Colors.grey,
                //         ),
                //       ),
                //     ),
                //     Expanded(child: Divider(color: Colors.grey)),
                //   ],
                // ),

                // const SizedBox(height: 20),

                // Don't have an account text with underline and navigation
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navigate to Sign Up Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterView()),
                      );
                    },
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: "Don't have an Account? "),
                          TextSpan(
                            text: 'Sign Up here',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable TextField Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool isPassword = false,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: const TextStyle(fontFamily: 'Poppins'),
        hintStyle: const TextStyle(fontFamily: 'Poppins'),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorText: errorText,
      ),
    );
  }

  // Form validation
  void _validateForm() {
    String email = emailController.text;
    String password = passwordController.text;

    // Reset errors
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    // Email Validation (checks for @gmail.com domain)
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(email)) {
      setState(() {
        _emailError = 'Please enter a valid Gmail address.';
      });
    }

    // Password Validation (checks for at least 8 characters)
    if (password.length < 8) {
      setState(() {
        _passwordError = 'Password must be at least 8 characters long.';
      });
    }

    // If no errors, attempt login
    if (_emailError == null && _passwordError == null) {
      login();
    }
  }
}
