import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Add this line to prevent shifting
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.task), label: "Quests"),
        BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: "Progress"),
        BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Inventory"),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
