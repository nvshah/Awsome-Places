import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../providers/awsome_places.dart';

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
      body: Consumer<AwesomePlaces>(
        child: Center(
          child: Text('No Places !, Add Some one...'),
        ),
        builder: (ctxt, awesomePlaces, ch) => awesomePlaces.items.length <= 0
            ? ch
            : ListView.builder(
                itemCount: awesomePlaces.items.length,
                itemBuilder: (ctxt, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(awesomePlaces.items[index].image),
                  ),
                  title: Text(awesomePlaces.items[index].title),
                  onTap: (){
                    //GoTo Detai Page...
                  },
                ),
              ),
      ),
    );
  }
}
