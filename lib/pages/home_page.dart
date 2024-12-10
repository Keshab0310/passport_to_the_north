// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passport_to_the_north/Widgets/user_model.dart';
import 'package:passport_to_the_north/Widgets/exp_bar.dart';
import 'package:passport_to_the_north/Widgets/floating_action_button.dart';
import 'package:passport_to_the_north/Widgets/floating_action_button.dart';
import 'package:passport_to_the_north/widgets/map_widget.dart';
import 'package:passport_to_the_north/widgets/search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

class HomePage extends StatefulWidget {
  final AppUser user;  // Changed from User to AppUser
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  LatLng mapCenter = const LatLng(46.493919, -80.995415);
  var markers = <Marker>[];
  bool _isLoading = false;

  late AppUser _currentUser;  // Changed from User to AppUser

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _getCurrentLocation();
  }

  // Rest of the code remains the same as your original implementation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("${_currentUser.username}'s Exploration"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getCurrentLocation,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Experience Progress Bar
          ExpProgressBar(
            currentExp: _currentUser.currentExp,
            totalExp: _currentUser.totalExp,
            league: _currentUser.league,
          ),

          // Search Box
          SearchBox(onSearch: _handleSearch),

          // Expandable Map Widget
          Expanded(
            child: MapWidget(
              initialCenter: mapCenter,
              initialZoom: 15.0,
              markers: markers,
              onTapMarker: _handleMarkerTap,
            ),
          ),
        ],
      ),

      // Floating Action Button for Navigation
      floatingActionButton: NavigateButton(
        onPressed: _handleNavigation,
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() => currentIndex = index);
          // Add navigation logic based on index if needed
          switch (index) {
            case 0:
            // Home page (current page)
              break;
            case 1:
            // Maybe achievements or profile page
              break;
            case 2:
            // Maybe settings or other functionality
              break;
          }
        },
      ),
    );
  }
}