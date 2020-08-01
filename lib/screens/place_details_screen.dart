import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/awsome_places.dart';
import './map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<AwesomePlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          //Wrap the Image
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //Address
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10,),
          FlatButton(child: Text('View on Map'), onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (ctxt) => MapScreen(initialLocation: selectedPlace.location,),
            ));
          },)
        ],
      ),
    );
  }
}
