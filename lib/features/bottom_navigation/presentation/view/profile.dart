import 'package:e_learning/features/auth/presentation/view/login_view.dart';
import 'package:e_learning/features/bottom_navigation/presentation/view/edit_profile_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90, // Increased AppBar height
        backgroundColor: Colors.white, // Consistent dark blue
        title: Row(
          children: [
            // Wrapping the logo with Expanded to handle overflow
            Expanded(
              child: Image.asset(
                'assets/images/logo.png',
                height: 50, // Adjusted logo size
                fit: BoxFit.contain, // Ensure the logo doesn't get stretched
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "", // Empty Text, can be added if needed
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: false, // Title aligned left with logo
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // User Info Card
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/images/user_photo.png'), // Replace with user photo
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Anjali Shrestha",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "softwarica",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Color(0xFF0A3D62),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Profile Options
          const _ProfileOption(
            icon: Icons.person,
            title: "Edit Profile",
            subtitle: "Edit your information",
          ),
          const _ProfileOption(
            icon: Icons.description,
            title: "My Documents",
            subtitle: "View your documents",
          ),
          const _ProfileOption(
            icon: Icons.task,
            title: "Tasks",
            subtitle: "View tasks for each week",
          ),
          const _ProfileOption(
            icon: Icons.timeline,
            title: "My Journey",
            subtitle: "View your progress of each module",
          ),
          const _ProfileOption(
            icon: Icons.book,
            title: "Books",
            subtitle: "Books you requested to borrow",
          ),
          const _ProfileOption(
            icon: Icons.book_outlined,
            title: "My Journals",
            subtitle: "Add or view your journal",
          ),
          const _ProfileOption(
            icon: Icons.support_agent,
            title: "Support Staffs",
            subtitle: "Request here to get support",
          ),
          const _ProfileOption(
            icon: Icons.settings,
            title: "Settings",
            subtitle: "Update password and details here",
          ),

          // Logout Option
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
              size: 30,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            subtitle: const Text("Logout your account from device"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginView(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF0A3D62), // Dark blue
        size: 30,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      onTap: () {
        // Add navigation or functionality here
      },
    );
  }
}
