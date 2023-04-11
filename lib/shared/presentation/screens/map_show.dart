import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  // final double latitude, longitude;
  const GoogleMapScreen({
    Key? key,
    // required this.latitude,
    // required this.longitude,
  }) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.5992, 72.9342),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          trafficEnabled: true,
          initialCameraPosition: _kGooglePlex,
          markers: {
            Marker(
              markerId: MarkerId("marker1"),
              position: LatLng(20.5992, 72.9342),
              draggable: true,
              // onDragEnd: (value) {
              //   // value is the new position
              // },
              // To do: custom marker icon
            ),
            // Marker(
            //   markerId: const MarkerId("marker2"),
            //   position: const LatLng(20.7702, 72.9824),
            // ),
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
