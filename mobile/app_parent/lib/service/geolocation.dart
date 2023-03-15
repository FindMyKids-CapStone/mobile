import 'package:geolocator/geolocator.dart';

Future getCurrentLocation() async {
  var currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  print(
      'currentPos------${currentPosition.latitude}, ${currentPosition.longitude}');
  // List addresses = await placemarkFromCoordinates(
  //     _currentPosition.latitude, _currentPosition.longitude);
  // print('getCurrentLocation-----${addresses.toString()}');
  // var _currentLocationTextController.text = addresses[0].name;
  // _layerController.insertMarker(0);
}
