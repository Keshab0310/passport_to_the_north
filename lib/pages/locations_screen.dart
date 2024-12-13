import 'package:flutter/material.dart';

class LocationsScreen extends StatefulWidget {
  final String category;

  const LocationsScreen({super.key, required this.category});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final Map<String, List<String>> _locationsByCategory = {
    'Hiking': ['Trail 1', 'Trail 2', 'Trail 3'],
    'Provincial Park': ['Park A', 'Park B'],
    'Tourist Attraction': ['Attraction 1', 'Attraction 2', 'Attraction 3'],
    'Museum': ['Museum X', 'Museum Y', 'Museum Z'],
    'Festival/Event': ['Festival 1', 'Festival 2', 'Festival 3'],
  };

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final locations = _locationsByCategory[widget.category] ?? [];
    final filteredLocations = locations
        .where((location) =>
        location.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            if (filteredLocations.isEmpty)
              const Text('No locations found.')
            else
              Expanded(
                child: ListView.builder(
                  itemCount: filteredLocations.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(filteredLocations[index]),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
