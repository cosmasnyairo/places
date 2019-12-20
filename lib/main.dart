import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/add_place_screen.dart';
import './screens/place_overview_screen.dart';
import './providers/places_provider.dart';
import 'screens/place_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: 'Places App',
        theme: ThemeData(
          cardColor: Colors.black26,
          primarySwatch: Colors.indigo,
          accentColor: Colors.teal,
        ),
        home: PlacesOverview(),
        routes: {
          'add-place': (ctx) => AddPlaceScreen(),
          'place-detail': (ctx) => PlaceDetail(), 
        },
      ),
    );
  }
}
