import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({Key? key}) : super(key: key);

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.03333, -122.35),
    zoom: 11.5,
  );
  GoogleMapController? _googleMapController;

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Location'),
      ),
      body: GoogleMap(
          onMapCreated: (controller) => _googleMapController = controller,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          initialCameraPosition:
              const CameraPosition(target: LatLng(37.03333, -122.35))),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController!.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),

      // const GoogleMap(
      //   myLocationButtonEnabled: false,
      //   zoomControlsEnabled: false,
      //   initialCameraPosition: _initialCameraPosition,
      // ),

      // body: Container(child:
      //  GoogleMap(
      //   mapType: MapType.hybrid,
      //   initialCameraPosition: _kGooglePlex,
      //   onMapCreated: (GoogleMapController controller) {
      //     _controller.complete(controller);
      //   },
      // ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
      // ,),
    );
  }
}
