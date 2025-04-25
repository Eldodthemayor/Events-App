import 'package:flutter/material.dart';
import 'package:fire_base/views/create_event.dart';
import 'package:fire_base/views/profile.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../views/home.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  List pages = [
    Home(),
    CreateEvent(),
    Profile(),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: SlidingClippedNavBar.colorful(
        selectedIndex: currentPage,
        onButtonPressed: (value) {
          setState(() {
            currentPage = value;
          });
        },
        barItems: [
          BarItem(
            icon: Icons.home,
            title: 'Home',
            activeColor: Colors.red,
            inactiveColor: Colors.grey,
          ),
          BarItem(
            icon: Icons.upload,
            title: 'Create event',
            activeColor: Colors.green,
            inactiveColor: Colors.grey,
          ),
          BarItem(
            icon: Icons.person,
            title: 'Profile',
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
