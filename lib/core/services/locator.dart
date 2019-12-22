import 'package:geolocator/geolocator.dart';

class Locator {
  static double _latitude;
  static double _longitude;

  static final manager = Geolocator();

  static Future<void> getCurrentLocation() async {
    try {
      Position position = await manager.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      _latitude = position.latitude;
      _longitude = position.longitude;
    } catch (error) {
      print(error);
    }
  }

  static double getLatitude() {
    return _latitude;
  }

  static double getLongitude() {
    return _longitude;
  }
}
