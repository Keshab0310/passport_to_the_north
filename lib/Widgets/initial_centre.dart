import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  void initState() {
    super.initState();
    // Default to a fallback location if no initial center is provided
    _center = widget.initialCenter ?? const LatLng(46.495633 , -80.9988953);
    _zoom = widget.initialZoom;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: _center,
        initialZoom: _zoom,
        minZoom: 9,
        maxZoom: 18,
      ),
      children: [
        TileLayer(
          urlTemplate:
          "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
          additionalOptions: {
            'accessToken': widget.mapboxAccessToken,
          },
          userAgentPackageName: 'com.example.passport_to_the_north',
          tileBuilder: (context, exception, stackTrace) {
            return Container(
              color: Colors.red,
              child: const Center(
                child: Text(
                  'Error loading map tile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
        // Attribution Widget (optional for Mapbox)
      ],
    );
  }
}
