import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';

class AwesomePlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  void addPlace(String title, File image) {
    final place = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image,
      location: null,
    );
    _items.add(place);
    notifyListeners();
  }
}
