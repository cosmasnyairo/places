import 'package:flutter/material.dart';
import 'dart:io';

import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';
import '../models/places.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  Future<void> addPlace(String pickedtitle, File pickedimage,
      PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedimage,
      location: updatedLocation,
      title: pickedtitle,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path, //store path to image
        'latitude': newPlace.location.latitude,
        'longitude': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );
  }

  Future<void> fetchandSetPlace() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (a) => Place(
            id: a['id'],
            title: a['title'],
            image: File(a['image']),
            location: PlaceLocation(
              latitude: a['latitude'],
              longitude: a['longitude'],
              address: a['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
