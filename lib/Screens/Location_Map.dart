import 'package:location/location.dart' as loc;
// import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({Key? key}) : super(key: key);

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(30.738045, 70),
    zoom: 10.5,
  );
  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;

  Marker? _liveLocation;

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
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController!.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin!.position,
                    zoom: 14.5,
                    tilt: 50,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600)),
              child: const Text('ORIGIN'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController!.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination!.position,
                    zoom: 14.5,
                    tilt: 50,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600)),
              child: const Text('DES'),
            ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _googleMapController = controller;
            },
            zoomControlsEnabled: false,
            myLocationButtonEnabled: true,
            initialCameraPosition: _initialCameraPosition,
            markers: {
              // if (_origin != null) _origin as Marker,
              // if (_destination != null) _destination as Marker,
              if (_liveLocation != null) _liveLocation as Marker,
            },
            onLongPress: _addMarker,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        // ignore: avoid_print
        onPressed: () {
          _currentLocation();
          // print('hello $_info');
          // _googleMapController!.animateCamera(
          //   _info != null
          //       ? CameraUpdate.newLatLngBounds(_info!.bounds, 100)
          //       : CameraUpdate.newCameraPosition(_initialCameraPosition),
          // );
        },
        child: const Icon(Icons.my_location_sharp),
      ),
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _googleMapController!;
    loc.LocationData? currentLocation;
    var location = new loc.Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }
    final postion = LatLng(currentLocation!.latitude!.toDouble(),
        currentLocation.longitude!.toDouble());
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: postion,
          zoom: 17.5,
        ),
      ),
    );
    setState(() {
      _liveLocation = Marker(
        markerId: const MarkerId('Live Location'),
        infoWindow: const InfoWindow(title: 'Live Location'),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        position: postion,
      );
    });
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      //origin is not set or origin and distinaton is set
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        _destination = null;
      });
    } else {
      //origin is set but no destination is set
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });
    }
  }
}
