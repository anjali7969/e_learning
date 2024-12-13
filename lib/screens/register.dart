import 'package:e_learning/screens/auth/account_created.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>(); // Global key for form validation
  String email = '';
  String password = '';
  String confirmPassword = '';
  String firstName = '';
  String lastName = '';

  // Error message state variables
  String emailError = '';
  String passwordError = '';

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _isEmailValid(String email) {
    // Real-time email validation: checks for "@gmail.com" and trims any extra spaces
    return email.trim().contains('@gmail.com');
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

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey, // Attach the form key for validation
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),

                  // Logo
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 220,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Title
                  const Center(
                    child: Text(
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Full Name Fields
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'First Name',
                          onChanged: (value) {
                            firstName = value;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildTextField(
                          label: 'Last Name',
                          onChanged: (value) {
                            lastName = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Email Field with Validation Error
                  _buildTextField(
                    label: 'Email ID',
                    onChanged: (value) {
                      setState(() {
                        email = value;
                        emailError = _isEmailValid(email)
                            ? ''
                            : 'Please enter a valid Gmail address.';
                      });
                    },
                    errorMessage: emailError,
                  ),

                  const SizedBox(height: 20),

                  // Password Field with Validation Error
                  _buildTextField(
                    label: 'Enter Password',
                    isPassword: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                        passwordError = _isPasswordValid(password)
                            ? ''
                            : 'Password must be at least 8 characters.';
                      });
                    },
                    errorMessage: passwordError,
                  ),

                  const SizedBox(height: 20),

                  // Confirm Password Field
                  _buildTextField(
                    label: 'Confirm Password',
                    isPassword: true,
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                  ),

                  const SizedBox(height: 30),

                  // Create Account Button
                  GestureDetector(
                    onTap: () {
                      // Handle button click, e.g., navigate to registration screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AccountCreatedPage(), // Replace with your registration screen
                        ),
                      );
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
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable TextField Widget
  Widget _buildTextField({
    required String label,
    bool isPassword = false,
    String errorMessage = '',
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            if (label == 'Email ID' && !_isEmailValid(value)) {
              return 'Please enter a valid Gmail address.';
            }
            if (label == 'Enter Password' && !_isPasswordValid(value)) {
              return 'Password must be at least 8 characters.';
            }
            return null; // Return null if no validation error
          },
        ),
        if (errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
