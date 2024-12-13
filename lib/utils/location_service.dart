import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadJsonToFirestore() async {
  try {
    // Load JSON file from assets
    String jsonString = await rootBundle.loadString('assets/data.json');
    List<dynamic> jsonData = jsonDecode(jsonString);

    // Reference Firestore collection
    CollectionReference locations = FirebaseFirestore.instance.collection('locations');

    // Write each JSON entry to Firestore
    for (var entry in jsonData) {
      await locations.add(entry);
    }

    print('Data uploaded successfully');
  } catch (e) {
    print('Error uploading JSON: $e');
  }
}
