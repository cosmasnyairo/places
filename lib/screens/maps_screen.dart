import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/places.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final isSelecting;

  const MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: -1.3066066642847955, longitude: 36.8016816303134),
    this.isSelecting = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          widget.isSelecting
              ? IconButton(
                  onPressed: _pickedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedLocation);
                        },
                  icon: Icon(Icons.check_circle),
                )
              : null
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.initialLocation.latitude,
              widget.initialLocation.longitude,
            ),
            zoom: 15),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _pickedLocation == null
            ? null
            : {
                Marker(
                    infoWindow: InfoWindow(title: 'Your Picked Location'),
                    markerId: MarkerId('m1'),
                    position: _pickedLocation),
              },
      ),
    );
  }
}
