import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomBar({required this.currentIndex, required this.onTap});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.lightBlue,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.car_crash),
          label: 'Car',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Appointment',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Kết nối salon'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
