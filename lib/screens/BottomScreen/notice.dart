import 'package:e_learning/models/notice.dart';
import 'package:flutter/material.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of dummy notices
    final List<Notice> notices = [
      Notice(
        title: "Semester Project Submission Guidelines",
        author: "Admin Office",
        description:
            "All students are required to submit their semester projects by January 10, 2025. Ensure you follow the provided guidelines and include all necessary documentation.",
        timestamp: "20 Dec 2024 - 10:00 AM",
      ),
      Notice(
        title: "Workshop on Flutter Development",
        author: "Tech Club",
        description:
            "Join us for an in-depth workshop on Flutter App Development on January 5, 2025. Learn how to build cross-platform applications with hands-on activities.",
        timestamp: "19 Dec 2024 - 03:00 PM",
      ),
      Notice(
        title: "Library Renovation Notice",
        author: "Library Staff",
        description:
            "The college library will be under renovation from January 1 to January 15, 2025. Students are advised to return borrowed books before December 30, 2024.",
        timestamp: "19 Dec 2024 - 12:15 PM",
      ),
      Notice(
        title: "Cultural Fest Announcement",
        author: "Event Committee",
        description:
            "Get ready for the annual cultural fest on January 25, 2025! Participate in exciting competitions and showcase your talents. Registration closes on January 10, 2025.",
        timestamp: "18 Dec 2024 - 09:00 AM",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notices'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: notices.length,
        itemBuilder: (context, index) {
          final notice = notices[index];
          return NoticeCard(notice: notice);
        },
      ),
    );
  }
}

class NoticeCard extends StatelessWidget {
  final Notice notice;

  const NoticeCard({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notice.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              notice.author,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              notice.description,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                notice.timestamp,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
