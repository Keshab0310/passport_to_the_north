import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> _searchResults = [];
  bool _isLoading = false;

  /// Firestore Search Function
  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) return; // Ignore empty searches

    setState(() {
      _isLoading = true;
    });

    try {
      // Query Firestore collection named 'locations'
      final querySnapshot = await FirebaseFirestore.instance
          .collection('locations')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff') // For prefix search
          .get();

      // Extract data from Firestore query
      final results =
      querySnapshot.docs.map((doc) => doc['name'] as String).toList();

      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error searching locations: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to search: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('Firestore Search', style: TextStyle(fontSize: 20)),
      ),
      body: Column(
        children: [
          // SearchBox widget
          SearchBox(onSearch: _performSearch),
          const SizedBox(height: 20),
          // Display search results
          Expanded(
            child: _isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : _searchResults.isEmpty
                ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.search_off, size: 50, color: Colors.grey),
                  SizedBox(height: 10),
                  Text(
                    'No results found',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            )
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.place,
                        color: Colors.blueAccent),
                    title: Text(
                      _searchResults[index],
                      style: const TextStyle(
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.grey),
                    onTap: () {
                      // Action on tap
                    },
                  ),
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
          prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => onSearch(''),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        ),
        onSubmitted: onSearch,
      ),
    );
  }
}
