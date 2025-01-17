import 'package:flutter/material.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Modules'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A3D62),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            LearningModuleCard(
              title: "ST6000CEM Individual Project Preparation",
              level: "Year Three",
              lessonsCompleted: "0/5",
              description:
                  "Prepare for your individual project with this structured module.",
              progress: 0.2,
            ),
            LearningModuleCard(
              title: "ST6003CEM Web API Development",
              level: "Year Three",
              lessonsCompleted: "2/6",
              description:
                  "Learn to build and integrate Web APIs using modern tools.",
              progress: 0.44,
            ),
            LearningModuleCard(
              title: "STA309IAE Design Thinking and Innovation",
              level: "Year Three",
              lessonsCompleted: "1/4",
              description:
                  "Explore innovative solutions through design thinking processes.",
              progress: 0.25,
            ),
          ],
        ),
      ),
    );
  }
}

class LearningModuleCard extends StatelessWidget {
  final String title;
  final String level;
  final String lessonsCompleted;
  final String description;
  final double progress;

  const LearningModuleCard({
    super.key,
    required this.title,
    required this.level,
    required this.lessonsCompleted,
    required this.description,
    required this.progress,
  });

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
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Level: $level",
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  "Lessons Completed: $lessonsCompleted",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: Colors.blueAccent,
              minHeight: 8,
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                child: const Text(
                  "Go To Module",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
