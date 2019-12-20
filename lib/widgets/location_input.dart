import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:places_app/screens/maps_screen.dart';

import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImage;

  void _showPreview(double latitude, double longitude) {
    final staticMap = LocationHelper.generatepreviewImage(
      latitude: latitude,
      longitude: longitude,
    );
    setState(() {
      _previewImage = staticMap;
    });
  }

  Future<void> _getCurrentLocation() async {
    final locdata = await Location().getLocation();
    _showPreview(locdata.latitude, locdata.longitude);
    widget.onSelectPlace(locdata.latitude, locdata.longitude);
  }

  Future<void> _selectmap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude,selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: _previewImage == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.error),
                      Text('No Location Chosen'),
                    ],
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    _previewImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20),
              ),
              elevation: 1,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).accentColor,
              onPressed: _getCurrentLocation,
            ),
            SizedBox(width: 20),
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20),
              ),
              elevation: 1,
              icon: Icon(Icons.map),
              label: Text('Choose From Map'),
              textColor: Theme.of(context).accentColor,
              onPressed: _selectmap,
            ),
          ],
        )
      ],
    );
  }
}
