import 'package:flutter/material.dart';
import 'package:north/locations_screen.dart'; // Import the LocationsScreen file

class QuestScreen extends StatelessWidget {
  const QuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {'name': 'Hiking', 'image': 'assets/hiking.jpg'},
      {'name': 'Provincial Park', 'image': 'assets/provincial_park.jpg'},
      {'name': 'Tourist Attraction', 'image': 'assets/tourist_attraction.jpg'},
      {'name': 'Museum', 'image': 'assets/museum.jpg'},
      {'name': 'Festival/Event', 'image': 'assets/festival.jpg'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: Image.asset(
                  category['image']!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(category['name']!),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationsScreen(
                        category: category['name']!,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}