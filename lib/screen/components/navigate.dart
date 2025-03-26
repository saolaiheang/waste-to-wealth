import 'package:flutter/material.dart';
import 'package:waste_to_wealth/screen/history.dart';
import 'package:waste_to_wealth/screen/homescreen.dart';
import 'package:waste_to_wealth/screen/profile.dart';
import 'package:waste_to_wealth/screen/social.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return; // Prevents unnecessary navigation

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PickupScheduleHistory()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SocialPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green.shade200,
      selectedItemColor: Colors.green[900],
      unselectedItemColor: Colors.green[700],
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex, // Set the currentIndex dynamically
      onTap: (index) => _onItemTapped(context, index), // Correct function reference
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "Social"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}

