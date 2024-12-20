import 'package:flutter/material.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A3D62), // Dark blue background
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png', // Replace with the correct logo path
              height: 30,
            ),
            const SizedBox(width: 8),
            const Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                            "S3-s1-C33C",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Anjali Shrestha",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "220385@softwarica.edu.np",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            "softwarica",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            "13701745",
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
                        color: Color(0xFF0A3D62), // Same as AppBar color
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
          ],
        ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ProfileOption({
    super.key,
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
