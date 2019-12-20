import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import '../providers/places_provider.dart';

class PlacesOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Great Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_location),
            onPressed: () {
              Navigator.of(context).pushNamed('add-place');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchandSetPlace(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Places>(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.error),
                      const Text('No Places Added Yet'),
                    ],
                  ),
                ),
                builder: (ctx, greatplace, ch) => greatplace.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatplace.items.length,
                        itemBuilder: (ctx, i) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('place-detail');
                          },
                          child: Column(
                            children: <Widget>[
                              Card(
                                elevation: 7,
                                color: null,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 170,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        child: Image.file(
                                          greatplace.items[i].image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        greatplace.items[i].title,
                                        textAlign: TextAlign.right,
                                        style:
                                            GoogleFonts.prociono(fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(' '+
                                        greatplace.items[i].location.address,
                                        textAlign: TextAlign.right,
                                        style:
                                            GoogleFonts.lato(fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 7),
                            ],
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
