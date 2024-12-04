import 'package:flutter/material.dart';

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
