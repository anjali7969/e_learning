import 'package:flutter/material.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({super.key});

  @override
  State<BottomNavigationView> createState() => BottomNavigationViewState();
}

class BottomNavigationViewState extends State<BottomNavigationView> {
  int selectedIndex = 0;

  List<Widget> lstBottomScreen = [
    // const HomeScreen(),
    // const learningScreen(), //PascalCase
    // const ProfileScreen(),

    // const NoticeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: lstBottomScreen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school), // Updated to represent Learning
            label: 'Learning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications), // Updated to represent Notice
            label: 'Notice',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
