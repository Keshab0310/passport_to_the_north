import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passport_to_the_north/models/user_model.dart';
import 'package:passport_to_the_north/widgets/exp_bar.dart';
import 'package:passport_to_the_north/widgets/floating_action_button.dart';
import 'package:passport_to_the_north/widgets/drawer_navigation.dart';
import 'package:passport_to_the_north/widgets/map_widget.dart';
import 'package:passport_to_the_north/widgets/search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:passport_to_the_north/pages/user_login.dart';

class HomePage extends StatefulWidget {
  final AppUser user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  LatLng mapCenter = const LatLng(46.493919, -80.995415);
  var markers = <Marker>[];
  bool _isLoading = false;

  late AppUser _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _getCurrentLocation();
  }

  // Location Services Method
  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        LocationSettings locationSettings =const LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 10,
        );
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings,
        );

        setState(() {
          mapCenter = LatLng(position.latitude, position.longitude);
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Error getting location: ${e.toString()}');
    }
  }

  // Search Handler
  void _handleSearch(String query) async {
    if (query.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid search query.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Firestore Query to search for locations
      final querySnapshot = await FirebaseFirestore.instance
          .collection('locations') // Replace with your Firestore collection name
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      // Parse results and update markers
      final newMarkers = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Marker(
          point: LatLng(data['latitude'], data['longitude']),
          child: const Icon(Icons.location_pin, color: Colors.blue, size: 40),
        );
      }).toList();

      setState(() {
        markers = newMarkers; // Update map markers
        _isLoading = false;
      });

      if (newMarkers.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No matching locations found.')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Error searching locations: ${e.toString()}');
    }
  }

  // Marker Tap Handler
  void _handleMarkerTap(LatLng point) {
    setState(() {
      markers.add(Marker(
        point: point,
        child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
      ));
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Marker added at ${point.latitude}, ${point.longitude}"),
        action: SnackBarAction(
            label: 'Navigate',
            onPressed: () {
              // Optional: Add navigation logic
            }),
      ),
    );
  }

  // Navigation Handler
  void _handleNavigation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigating to nearby points...')),
    );
  }

  // Logout Method
  void _logout() async {
    try {
      await fb_auth.FirebaseAuth.instance.signOut();
      // Navigate back to login page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      _showErrorSnackBar('Logout failed: ${e.toString()}');
    }
  }

  // Error SnackBar Method
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Experience Update Method
  void _updateUserExperience(int expGained) {
    setState(() {
      _currentUser.updateExperience(expGained);
    });

    // Update Firestore with new experience
    _updateUserInFirestore();
  }

  // Firestore User Update Method
  Future<void> _updateUserInFirestore() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser.id)
          .update({
        'currentExp': _currentUser.currentExp,
        'totalExp': _currentUser.totalExp,
        'league': _currentUser.league.toString().split('.').last,
      });
    } catch (e) {
      _showErrorSnackBar('Error updating user experience');
    }
  }

  void _onItemSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
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
              initialZoom: 17.0,
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

      // Drawer Navigation
      drawer: DrawerNavWithIndex(
        username: _currentUser.username,
        email: _currentUser.email,
        currentIndex: currentIndex,
        onItemSelected: _onItemSelected,
      ),
    );
  }
}
