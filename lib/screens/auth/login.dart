import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),

            // Logo
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 170,
              ),
            ),

            const SizedBox(height: 20),

            // Title
            const Center(
              child: Text(
                'Sign in to your account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Email Input Field
            _buildTextField(label: 'Email', hintText: 'Username or Email ID'),

            const SizedBox(height: 20),

            // Password Input Field
            _buildTextField(
                label: 'Password',
                hintText: 'Enter Password',
                isPassword: true),

            const SizedBox(height: 20),

            // Sign In Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle sign-in action
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Divider with "Sign in with"
            const Row(
              children: [
                Expanded(child: Divider(color: Colors.grey)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Sign in with',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey)),
              ],
            ),

            const SizedBox(height: 20),

            // Social Login Buttons
            Column(
              children: [
                _buildSocialButton(
                  label: 'Facebook',
                  iconPath: 'assets/icon/facebook.png',
                  onPressed: () {},
                ),
                const SizedBox(height: 15),
                _buildSocialButton(
                  label: 'Google',
                  iconPath: 'assets/icon/google.png',
                  onPressed: () {},
                ),
                const SizedBox(height: 15),
                _buildSocialButton(
                  label: 'Microsoft',
                  iconPath: 'assets/icon/microsoft.png',
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Reusable TextField Widget
  Widget _buildTextField(
      {required String label,
      required String hintText,
      bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  // Reusable Social Button Widget
  Widget _buildSocialButton({
    required String label,
    required String iconPath,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 24),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
