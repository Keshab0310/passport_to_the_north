import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addLocation(String name, double latitude, double longitude) async {
  CollectionReference locations = FirebaseFirestore.instance.collection('locations');

  await locations.add({
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
  }).then((value) => print("Location Added"))
      .catchError((error) => print("Failed to add location: $error"));
}

// Example usage
