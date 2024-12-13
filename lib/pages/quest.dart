
import 'package:flutter/material.dart';
import 'package:northern_passport_to_the_north/location_details_screen.dart'; // Import the LocationDetailsScreen

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
        title: const Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32, color: Colors.white
          ),
        ),
        backgroundColor: Colors.brown,
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
                title: Text(
                  category['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16, // Bold category names
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationDetailsScreen(
                        categoryName: category['name']!,
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
