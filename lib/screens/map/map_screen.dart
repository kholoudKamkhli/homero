import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:latlong2/latlong.dart" as latLng;
class MapScreen extends StatelessWidget {
  static const String routeName = "mapScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(30.0444, 31.2357),
          zoom: 9.2,
        ),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
        ],
      ),
    );
  }
}
