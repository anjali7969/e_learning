import 'package:e_learning/features/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>(); // Global key for form validation
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Error message state variables
  String emailError = '';
  String passwordError = '';

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _isEmailValid(String email) {
    return email.trim().contains('@gmail.com');
  }

  @override
  void initState() {
    super.initState();
    Hive.initFlutter(); // Ensure Hive is initialized
  }

  void _saveUserData() async {
    if (passwordController.text != confirmPasswordController.text) {
      _showErrorSnackBar("Passwords do not match.");
      return;
    }

    var userBox = await Hive.openBox('users');

    userBox.put(emailController.text, {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    });

    _showSuccessSnackBar(context); // Show the success snackbar
  }

  // Function to show the success Snackbar
  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Registered successfully!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green, // Green background for success
        duration: Duration(seconds: 3), // Display for 3 seconds
      ),
    );

    // Wait for 3 seconds (the duration of the Snackbar)
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        // After the Snackbar disappears, navigate to the LoginPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const LoginPage()), // Replace with your login page
        );
      }
    });
  }

  // Function to show the error Snackbar
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red, // Red background for error
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo positioned at the top of the screen
              Image.asset(
                'assets/images/logo.png', // Adjust the image path
                height: 150, // Adjust the logo size
              ),
              const SizedBox(height: 20), // Spacing between logo and text

              // Main text
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
              const Text(
                'Create your account to embark on your \neducational adventure',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30), // Spacing between text and form

              // Full Name Field
              _buildTextField(
                label: 'Name',
                controller: nameController,
              ),
              const SizedBox(height: 20), // Spacing between form fields

              // Email Field with Validation Error
              _buildTextField(
                label: 'Email ID',
                controller: emailController,
                errorMessage: emailError,
                onChanged: (value) {
                  setState(() {
                    emailError = _isEmailValid(value)
                        ? ''
                        : 'Please enter a valid Gmail address.';
                  });
                },
              ),
              const SizedBox(height: 20), // Spacing between form fields

              // Password Field with Validation Error
              _buildTextField(
                label: 'Enter Password',
                controller: passwordController,
                isPassword: true,
                errorMessage: passwordError,
                onChanged: (value) {
                  setState(() {
                    passwordError = _isPasswordValid(value)
                        ? ''
                        : 'Password must be at least 8 characters.';
                  });
                },
              ),
              const SizedBox(height: 20), // Spacing between form fields

              // Confirm Password Field
              _buildTextField(
                label: 'Confirm Password',
                controller: confirmPasswordController,
                isPassword: true,
              ),
              const SizedBox(height: 30), // Spacing between form fields

              // Create Account Button
              GestureDetector(
                onTap: () {
                  // Check if email and password are valid before saving
                  if (_isEmailValid(emailController.text) &&
                      _isPasswordValid(passwordController.text)) {
                    _saveUserData();
                  } else {
                    // Show error message if validation fails
                    setState(() {
                      if (!_isEmailValid(emailController.text)) {
                        emailError = 'Please enter a valid Gmail address.';
                      }
                      if (!_isPasswordValid(passwordController.text)) {
                        passwordError =
                            'Password must be at least 8 characters.';
                      }
                    });
                  }
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
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

  // Reusable TextField Widget with black border
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    String errorMessage = '',
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
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
