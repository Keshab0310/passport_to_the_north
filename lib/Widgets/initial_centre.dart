import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InitialMapWidget extends StatefulWidget {
  final LatLng? initialCenter;
  final double initialZoom;
  final String mapboxAccessToken;

  const InitialMapWidget({
    super.key,
    this.initialCenter,
    this.initialZoom = 18,
    required this.mapboxAccessToken,
  });

  @override
  _InitialMapWidgetState createState() => _InitialMapWidgetState();
}

class _InitialMapWidgetState extends State<InitialMapWidget> {
  late LatLng _center;
  late double _zoom;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _zoom = widget.initialZoom;
    _initializeMapCenter();
  }

  Future<void> _initializeMapCenter() async {
    try {
      // Query Firestore for a predefined location
      final querySnapshot = await FirebaseFirestore.instance
          .collection('locations')
          .where('name', isEqualTo: 'Default Place') // Update name filter if needed
          .limit(10)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        setState(() {
          _center = LatLng(data['latitude'], data['longitude']);
          _isLoading = false;
        });
      } else {
        // Fallback to device location if Firestore fails
        await _getCurrentDeviceLocation();
      }
    } catch (e) {
      await _getCurrentDeviceLocation(); // Handle errors
    }
  }

  Future<void> _getCurrentDeviceLocation() async {
    try {
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      );
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _center = widget.initialCenter ?? const LatLng(46.495633, -80.9988953);
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return FlutterMap(
      options: MapOptions(
        initialCenter: _center,
        initialZoom: _zoom,
      ),
      children: [
        TileLayer(
          urlTemplate:
          "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token={accessToken}",
          additionalOptions: {
            'accessToken': widget.mapboxAccessToken,
          },
        ),
      ],
    );
  }
}
