import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class InitialMapWidget extends StatelessWidget {
  final LatLng initialCenter;
  final double initialZoom;
  final String attributionUrl;

  const InitialMapWidget({
    super.key,
    required this.initialCenter,
    this.initialZoom = 9.2,
    this.attributionUrl = 'https://openstreetmap.org/copyright',
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: initialZoom,
      ),
      children: [
        // Tile Layer using OpenStreetMap
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.passport_to_the_north',
        ),
        // Rich Attribution Widget for OSM credits
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => launchUrl(Uri.parse(attributionUrl)),
            ),
          ],
        ),
      ],
    );
  }
}
