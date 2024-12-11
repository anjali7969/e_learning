import 'package:e_learning/screens/auth/account_created.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            // Logo
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 100,
              ),
            ),

            const SizedBox(height: 20),

            // Title
            const Center(
              child: Text(
                'Create Your Account',
                style: TextStyle(
                  fontSize: 22,
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
                  child: _buildTextField(label: 'First Name'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(label: 'Last Name'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Email Field
            _buildTextField(label: 'Email ID'),

            const SizedBox(height: 20),

            // Password Field
            _buildTextField(label: 'Enter Password', isPassword: true),

            const SizedBox(height: 20),

            // Confirm Password Field
            _buildTextField(label: 'Confirm Password', isPassword: true),

            const SizedBox(height: 30),

            // Create Account Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the "Account Created" page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountCreatedPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Divider with "Sign up with"
            const Row(
              children: [
                Expanded(child: Divider(color: Colors.grey)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Sign up with',
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
  Widget _buildTextField({required String label, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
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
