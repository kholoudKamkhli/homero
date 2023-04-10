import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:latlong2/latlong.dart" as latLng;

class MapScreen extends StatefulWidget {
  static const String routeName = "mapScreen";

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Marker? pickUpPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(30.0444, 31.2357), zoom: 14),
        markers: {
          if (pickUpPoint != null) pickUpPoint!,
        },
        onLongPress: addMarker,
      ),
    );
  }

  addMarker(LatLng pos) {
    {
      pickUpPoint = Marker(
        markerId: MarkerId("pick up point"),
        infoWindow: InfoWindow(title: "Pick Up Point"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        position: pos,
      );
    }
    setState(() {

    });
  }
}
