import 'package:flutter/material.dart';

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key});

  @override
  State<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> {
  final List<String> _categories = [
    'Hiking',
    'Provincial Park',
    'Tourist Attraction',
    'Museum',
    'Festival/Event',
  ];

  final Map<String, List<String>> _locationsByCategory = {
    'Hiking': ['Trail 1', 'Trail 2', 'Trail 3'],
    'Provincial Park': ['Park A', 'Park B'],
    'Tourist Attraction': ['Attraction 1', 'Attraction 2', 'Attraction 3'],
    'Museum': ['Museum X', 'Museum Y', 'Museum Z'],
    'Festival/Event': ['Festival 1', 'Festival 2', 'Festival 3'],
  };

  String? _selectedCategory;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<String> filteredLocations = [];
    if (_selectedCategory != null) {
      filteredLocations = _locationsByCategory[_selectedCategory!]!
          .where((location) => location
          .toLowerCase()
          .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quest Screen'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Select a Category:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            // Category Dropdown
            DropdownButton<String>(
              value: _selectedCategory,
              hint: const Text('Category'),
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            // Search Bar: Positioned above locations
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Location',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
            const SizedBox(height: 20),
            // Display Locations below search bar
            if (_selectedCategory != null) ...[
              const SizedBox(height: 20),
              const Text(
                'Locations:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              if (filteredLocations.isEmpty)
                const Text('No locations found.')
              else
                for (var location in filteredLocations)
                  ListTile(
                    title: Text(location),
                  ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
