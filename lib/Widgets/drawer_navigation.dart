import 'package:flutter/material.dart';
import 'package:passport_to_the_north/pages/quest.dart';
import 'package:passport_to_the_north/pages/progress.dart';

class DrawerNavWithIndex extends StatelessWidget {
  final String username;
  final String email;
  final int currentIndex;
  final Function(int) onItemSelected;

  const DrawerNavWithIndex({
    super.key,
    required this.username,
    required this.email,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(username),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              child: Text(username.isNotEmpty
                  ? username[0].toUpperCase()
                  : ''),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            selected: currentIndex == 0,
            onTap: () {
              onItemSelected(0);
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.task),
            title: const Text("Quests"),
            selected: currentIndex == 1,
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuestScreen())
              ); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.emoji_events),
            title: const Text("Progress"),
            selected: currentIndex == 2,
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProgressPage())
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text("Inventory"),
            selected: currentIndex == 3,
            onTap: () {
              onItemSelected(3);
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
