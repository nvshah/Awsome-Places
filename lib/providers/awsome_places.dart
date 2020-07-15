import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helpers.dart';

class AwesomePlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items => [..._items];

  //Add data to sqlite database behind the Mobile Storage
  void addPlace(String title, File image) {
    final place = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: null,
    );
    _items.add(place);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': place.id,
      'title': place.title,
      //As we cannot store the image File but we can store path in database
      'image': place.image.path,
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
              location: null,
            ))
        .toList();
    notifyListeners();
  }
}
