import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helpers.dart';
import '../helpers/location_helper.dart';

class AwesomePlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items => [..._items];

  //Add data to sqlite database behind the Mobile Storage
  Future<void> addPlace (String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getLocationAddress(location.latitude, location.longitude);
    final updatedLocation = PlaceLocation(latitude: location.latitude, longitude: location.longitude, address: address);

    final place = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: updatedLocation,
    );

    //Add Place locally
    _items.add(place);
    notifyListeners();
    
    //Add place in db
    DBHelper.insert('user_places', {
      'id': place.id,
      'title': place.title,
      //As we cannot store the image File but we can store path in database
      'image': place.image.path,
      'loc_lat': location.latitude,
      'loc_lng': location.longitude,
      'address': location.address,
    });
  }

  //fetch data from sqlite database & set it to our data model over here
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(latitude: item['loc_lat'], longitude: item['loc_lng'], address: item['address']),
            ))
        .toList();
    notifyListeners();
  }
}
