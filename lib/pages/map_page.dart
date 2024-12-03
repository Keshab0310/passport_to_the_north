import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'user_login.dart';
class MapNavigationPage extends StatelessWidget {
  const MapNavigationPage({super.key});

  Future<Map<String, dynamic>?> fetchLocation(String query) async {
    const String accessToken = 'pk.eyJ1Ijoia2VzaGFiOTkiLCJhIjoiY200N3hxanpvMGFmNzJtcTBkY3UzbTRnayJ9.U2Oa6NSS2o2QZi-8TCW1mA';
    final Uri url = Uri.parse(
      'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=$accessToken',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'longitude': data['features'][0]['geometry']['coordinates'][0],
        'latitude': data['features'][0]['geometry']['coordinates'][1],
      };
    } else {
      return null;
    }
  }

  Future<void> openGoogleMaps(double latitude, double longitude) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    final Uri uri = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open Google Maps.';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Navigation Example"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String query = "Eiffel Tower";
            final location = await fetchLocation(query);
            if (location != null) {
              double latitude = location['latitude'];
              double longitude = location['longitude'];
              await openGoogleMaps(latitude, longitude);
            } else {
              debugPrint("Location not found");
            }
          },
          child: const Text("Navigate to Eiffel Tower"),
        ),
      ),
    );
  }
}
