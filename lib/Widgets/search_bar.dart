import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> _searchResults = [];

  /// Firestore Search Function
  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) return; // Ignore empty searches

    try {
      // Query Firestore collection named 'locations'
      final querySnapshot = await FirebaseFirestore.instance
          .collection('locations')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff') // For prefix search
          .get();

      // Extract data from Firestore query
      final results = querySnapshot.docs.map((doc) => doc['name'] as String).toList();

      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      debugPrint('Error searching locations: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to search: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firestore Search')),
      body: Column(
        children: [
          // SearchBox widget
          SearchBox(onSearch: _performSearch),
          const SizedBox(height: 20),
          // Display search results
          Expanded(
            child: _searchResults.isEmpty
                ? const Center(child: Text('No results found'))
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResults[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final Function(String) onSearch;

  const SearchBox({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search for a location",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onSubmitted: onSearch,
      ),
    );
  }
}