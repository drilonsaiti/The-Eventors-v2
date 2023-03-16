import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation {
  static Future<Map<String, String>> getUserLocation() async {
    print("IN");

    var position = await Geolocator.getCurrentPosition();
    Map<String, String> map = {
      "lat": position.latitude.toString(),
      "lng": position.longitude.toString()
    };
    /* final address = await Geocoder2.getDataFromCoordinates(
        latitude: position.latitude,
        longitude: position.longitude,
        googleMapApiKey: "AIzaSyC7l_4GjrSdkBAWNxvvZRCvbFuJ7dQ5Oe4");
    var first = address.address;*/

    return map;
  }

  static Future<String> getAddres() async {
    print("IN");

    var position = await Geolocator.getCurrentPosition();
    final address = await Geocoder2.getDataFromCoordinates(
        latitude: position.latitude,
        longitude: position.longitude,
        googleMapApiKey: "AIzaSyC7l_4GjrSdkBAWNxvvZRCvbFuJ7dQ5Oe4");
    var first = address.address;

    return first;
  }
}
