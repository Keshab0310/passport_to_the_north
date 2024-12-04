import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final LatLng initialCenter;
  final double initialZoom;
  final Function(LatLng) onTapMarker;
  final List<Marker> markers;

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
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: markers,
        ),
      ],
    );
  }
}
