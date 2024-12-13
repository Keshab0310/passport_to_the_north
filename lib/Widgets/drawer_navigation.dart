import 'package:flutter/material.dart';
import 'package:passport_to_the_north/pages/quest.dart';
import 'package:passport_to_the_north/pages/progress.dart';

import '../models/user_model.dart';

class DrawerNavWithIndex extends StatelessWidget {
  // final String username;
  // final String email;
  final AppUser appUser;
  final int currentIndex;
  final Function(int) onItemSelected;

  const DrawerNavWithIndex({
    super.key,
    // required this.username,
    // required this.email,
    required this.currentIndex,
    required this.onItemSelected,
    required this.appUser,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color(0xFF4E342E), // Deep brown for background
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70), // Text color
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF5AB99)), // Accent color for icons
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                appUser.username,
                style: const TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                appUser.email,
                style: const TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: const Color(0xFFF5AB99), // Light peach for contrast
                child: Text(
                  appUser.username.isNotEmpty ? appUser.username[0].toUpperCase() : '',
                  style: const TextStyle(color: Color(0xFF4E342E)), // Match drawer background
                ),
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6D4C41), Color(0xFF8D6E63)], // Gradient with brown tones
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.home,
              text: "Home",
              selected: currentIndex == 0,
              onTap: () {
                onItemSelected(0);
                Navigator.pop(context);
              },
            ),
            _buildDrawerItem(
              icon: Icons.task,
              text: "Quests",
              selected: currentIndex == 1,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  QuestScreen(appUser: appUser)),
                );
              },
            ),
            _buildDrawerItem(
              icon: Icons.emoji_events,
              text: "Progress",
              selected: currentIndex == 2,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const ProgressPage()),
                );
              },
            ),
            _buildDrawerItem(
              icon: Icons.inventory,
              text: "Inventory",
              selected: currentIndex == 3,
              onTap: () {
                onItemSelected(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      selected: selected,
      selectedTileColor: const Color(0xFFF5AB99).withOpacity(0.2), // Soft highlight
      onTap: onTap,
    );
  }
}
