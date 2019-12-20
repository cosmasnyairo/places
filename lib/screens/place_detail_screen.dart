import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/maps_screen.dart';
import 'package:provider/provider.dart';

import '../providers/places_provider.dart';

class PlaceDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments; 
    final selectedPlace =
        Provider.of<Places>(context).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: GoogleFonts.grenze(),
          ),
          FlatButton(
            child: Text('View on Map'),
            color: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (a) => MapScreen(
                  initialLocation: selectedPlace.location,
                  isSelecting: false,
                ),
              ));
            },
          )
        ],
      ),
    );
  }
}
