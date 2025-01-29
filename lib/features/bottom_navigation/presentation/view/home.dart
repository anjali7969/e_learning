import 'package:e_learning/widgets/announcement_card.dart';
import 'package:e_learning/widgets/module_card.dart';
import 'package:e_learning/widgets/quick_link.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A3D62),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Banner
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: const Color(0xFF0A3D62),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back! Anjali",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Discover new courses, check announcements, and continue your learning journey.",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.school,
                      size: 60,
                      color: Colors.white, // White icon color for consistency
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Quick Links
            const Text(
              "Quick Links",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              children: const [
                QuickLink(
                  icon: Icons.book,
                  label: "Courses",
                  iconColor: Color(0xFF0A3D62), // Updated icon color
                ),
                QuickLink(
                  icon: Icons.notifications,
                  label: "Notices",
                  iconColor: Color(0xFF0A3D62), // Updated icon color
                ),
                QuickLink(
                  icon: Icons.calendar_today,
                  label: "Events",
                  iconColor: Color(0xFF0A3D62), // Updated icon color
                ),
                QuickLink(
                  icon: Icons.task,
                  label: "Tasks",
                  iconColor: Color(0xFF0A3D62), // Updated icon color
                ),
                QuickLink(
                  icon: Icons.person,
                  label: "Profile",
                  iconColor: Color(0xFF0A3D62), // Updated icon color
                ),
                QuickLink(
                  icon: Icons.support_agent,
                  label: "Support",
                  iconColor: Color(0xFF0A3D62), // Updated icon color
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Announcements Section
            const Text(
              "Announcements",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const AnnouncementCard(
              title: "New Course Available: Flutter Development",
              description:
                  "Explore our new course on Flutter app development and build cross-platform mobile applications.",
              date: "20 Dec 2024",
            ),
            const AnnouncementCard(
              title: "Holiday Notice",
              description:
                  "The institute will remain closed from December 25, 2024, to January 1, 2025, for the winter holidays.",
              date: "18 Dec 2024",
            ),
            const SizedBox(height: 16),

            // Featured Modules
            const Text(
              "Featured Modules",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const ModuleCard(
              moduleName: "Web API Development",
              progress: 0.75,
            ),
            const ModuleCard(
              moduleName: "Design Thinking and Innovation",
              progress: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
