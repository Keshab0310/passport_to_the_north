import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../Widgets/initial_centre.dart'; // Import the MapWidget

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OpenStreetMap Example"),
      ),
      body: InitialMapWidget(
        initialCenter: LatLng(46.5513927, -81.0354982),
        initialZoom: 9.2,
      ),
    );
  }
}
