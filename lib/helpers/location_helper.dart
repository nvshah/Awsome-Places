import 'dart:convert';

import 'package:http/http.dart' as http;

const TOMTOM_API_KEY = 'rdojZCkluXGMINlCLTzUiXqAZMHX4Xgu';
const GOOGLE_API_KEY = 'AIzaSyBg9yn5JtQgKRFbg6FCTy4ewbF24kRuAYI';

class LocationHelper{
  static String generateLocationPreviewImage({double latitude, double longitude}){
    return 'http://api.tomtom.com/map/1/staticimage?key=$TOMTOM_API_KEY&zoom=13&center=$latitude,$longitude&format=jpg&layer=basic&style=main&width=600&height=300&view=Unified&language=en-GB';
  }
 
  //Get Address from Latitiude, Longitude via reverse geo-coding
  static Future<String> getLocationAddress(double lat, double lng) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address']; 
  }
}