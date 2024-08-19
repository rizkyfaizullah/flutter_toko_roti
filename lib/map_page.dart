import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  LatLng _initialPosition = LatLng(-7.052899, 110.435665);
  LatLng? _pickedLocation;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onTap(LatLng location) {
    setState(() {
      _pickedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Lokasi Anda'),
        backgroundColor: Colors.amber[300],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14.0,
        ),
        onTap: _onTap,
        markers: _pickedLocation == null
            ? {}
            : {
                Marker(
                  markerId: MarkerId('pickedLocation'),
                  position: _pickedLocation!,
                ),
              },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        backgroundColor: Colors.amber[300],
        onPressed: () {
          if (_pickedLocation != null) {
            Navigator.pop(context, _pickedLocation);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Pilih lokasi dengan mengetuk pada peta')),
            );
          }
        },
      ),
    );
  }
}
