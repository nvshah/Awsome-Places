import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/awsome_places.dart';
import '../widgets/location_input.dart';
import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation; 

  //Useful When Image is inputted to grab the image
  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  //Useful when location is selected, to grab the location
  void _selectLocation(double lat, double lng){
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng,);
  }

  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null){
      return; 
    }
    //Add place to Awesome Place Lists
    Provider.of<AwesomePlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage, _pickedLocation);
    //Go Back
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //This will allow child to take all available width surrounding
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title',),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10,),
                    ImageInput(_selectImage),
                    SizedBox(height: 10,),
                    LocationInput(_selectLocation),
                  ],
                ),
              ),
            ),
          ),
          //ADD ICON - to initiate the process of saving the data to db
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: _savePlace,
            //loses shadow
            elevation: 0,
            //remove all margin
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
