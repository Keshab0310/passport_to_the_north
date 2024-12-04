import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:passport_to_the_north/Widgets/exp_bar.dart';
import 'package:passport_to_the_north/Widgets/floating_action_button.dart';
import 'package:passport_to_the_north/Widgets/buttom_nav_bar.dart';
import 'package:passport_to_the_north/Widgets/map_widget.dart';
import 'package:passport_to_the_north/Widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  LatLng mapCenter = const LatLng(46.493919, -80.995415);
  var markers = <Marker>[];
  bool _isLoading = false;
  int currentExp = 1200;
  int totalExp = 1600;
  int currentLevel = 5;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }
  Future<void> _getCurrentLocation() async{
    setState(() {
      _isLoading = true;
    });

    try {
      // Request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        // Get current position
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        setState(() {
          mapCenter = LatLng(position.latitude, position.longitude);
          _isLoading = false;
        });
      }
    } catch(e){
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Error getting location');
    }
  }

  void _handleSearch(String query) {
    // Simulate search handling logic
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Searching for $query...')));
  }

  void _handleMarkerTap(LatLng point) {
    setState(() {
      markers.add(Marker(
        point: point,
        child:  const Icon(Icons.location_pin, color: Colors.red, size: 40,)

      ));
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Marker added at ${point.latitude}, ${point.longitude}"),
      action: SnackBarAction(label: 'Navigate', onPressed: () {}),
    ));
  }

  void _handleNavigation(){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Navigating to nearby points...')),
    );
  }

  void _showErrorSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),
      backgroundColor: Colors.red,)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Explore & Earn"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getCurrentLocation,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Experience Progress Bar
          ExpProgressBar(
            currentExp: currentExp,
            totalExp: totalExp,
            level: currentLevel,
          ),

          // Search Box
          SearchBox(onSearch: _handleSearch),

          // Expandable Map Widget
          Expanded(
            child: MapWidget(
              initialCenter: mapCenter,
              initialZoom: 12.0,
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
        onTap: (index) => setState(() => currentIndex = index),
      ),
    );
  }
}