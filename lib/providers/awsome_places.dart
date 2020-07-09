import 'package:flutter/foundation.dart';

import '../models/place.dart';

class AwesomePlaces with ChangeNotifier{
  List<Place> _items = [];

  List<Place> get items => [..._items];
}