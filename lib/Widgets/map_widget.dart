import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final LatLng initialCenter;
  final double initialZoom;
  final Function(LatLng) onTapMarker;
  final List<Marker> markers;
  final String mapboxAccessToken = 'pk.eyJ1Ijoia2VzaGFiOTkiLCJhIjoiY200ODBhNTh5MGJ6OTJrb3NzcTQ0ODgxbCJ9.bOzGye56v0wauOuA-keiHg';
  final String mapboxStyle = 'mapbox/navigation-night-v1'; // Change style if needed


  const MapWidget({
    super.key,
    required this.initialCenter,
    required this.initialZoom,
    required this.onTapMarker,
    required this.markers,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: initialZoom,
        onTap: (tapPosition, point) => onTapMarker(point),
      ),
      children: [
        TileLayer(
          urlTemplate:
          "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
          additionalOptions: {
            'id' : mapboxStyle,
            'accessToken': mapboxAccessToken,
          },
        ),
        MarkerLayer(
          markers: markers,
        ),
      ],
    );
  }
}