const TOMTOM_API_KEY = 'rdojZCkluXGMINlCLTzUiXqAZMHX4Xgu';

class LocationHelper{
  static String generateLocationPreviewImage({double latitude, double longitude}){
    return 'http://api.tomtom.com/map/1/staticimage?key=$TOMTOM_API_KEY&zoom=13&center=$latitude,$longitude&format=jpg&layer=basic&style=main&width=600&height=300&view=Unified&language=en-GB';
  }
}