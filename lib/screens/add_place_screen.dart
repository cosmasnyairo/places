import 'dart:io';
import 'package:flutter/material.dart';
import 'package:places_app/models/places.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  File _pickedImage;
  PlaceLocation _pickedLocation;
  final _titleController = TextEditingController();

  void _selectedImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double latitude, double longitude) {
    _pickedLocation = PlaceLocation(
      latitude: latitude,
      longitude: longitude,
    );
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }
    Provider.of<Places>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  SizedBox(height: 20),
                  ImageInput(_selectedImage),
                  SizedBox(height: 10),
                  LocationInput(_selectPlace)
                ],
              ),
            ),
          ),
          Container(
            height: 55,
            child: RaisedButton.icon(
              label: Text(
                'Add Place',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              splashColor: Theme.of(context).accentColor,
              icon: Icon(Icons.add, color: Colors.white),
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Colors.black,
              onPressed: _savePlace,
            ),
          ),
        ],
      ),
    );
  }
}
