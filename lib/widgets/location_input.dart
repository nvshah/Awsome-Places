import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _previewMap(double lat, double lng){
    //Get the static Map Image URL
    final staticMapImgUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImageUrl = staticMapImgUrl;
    });
  }

  //Get the Current Location
  Future<void> _getCurrentUserLocation() async {
    try{
      final locData = await Location().getLocation();
      _previewMap(locData.latitude, locData.longitude);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    }catch(error){
      return;
    }
  }

  Future<void> _selectOnMap() async {
    //It will tell that once aftr pushed when you are returning back It will retuen LatLng
    final selectedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      //display cross instead of back arrow
      fullscreenDialog: true,
        builder: (ctxt) => MapScreen(
              isSelecting: true,
            )));
    if(selectedLocation == null){
      return;
    }
    //Update Image in Location Image Box
    _previewMap(selectedLocation.latitude, selectedLocation.longitude);
    //Pass Selected Location details to Form Page/screen
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //LOCATION MAP BOX
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No Location Choosen !',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        //BUTTONS
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current location'),
              onPressed: _getCurrentUserLocation,
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select from Map'),
              onPressed: _selectOnMap,
            ),
          ],
        )
      ],
    );
  }
}
