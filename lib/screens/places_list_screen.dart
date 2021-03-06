import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../providers/awsome_places.dart';
import '../screens/place_details_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        //For the first time when we come to this page
        future: Provider.of<AwesomePlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctxt, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<AwesomePlaces>(
              //This allows us to rebuild the below parts only from further updates
                child: Center(
                  child: Text('No Places !, Add Some one...'),
                ),
                builder: (ctxt, awesomePlaces, ch) =>
                    awesomePlaces.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: awesomePlaces.items.length,
                            itemBuilder: (ctxt, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(awesomePlaces.items[index].image),
                              ),
                              title: Text(awesomePlaces.items[index].title),
                              subtitle: Text(awesomePlaces.items[index].location.address),
                              onTap: () {
                                //GoTo Detail Page...
                                Navigator.of(context).pushNamed(PlaceDetailsScreen.routeName, arguments: awesomePlaces.items[index].id);
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
