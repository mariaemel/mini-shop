import 'package:geolocator/geolocator.dart';
import 'package:mini_shop/features/map/data/models/map.dart';

abstract class AppLocation {
  Future<AppLatLong> getCurrentLocation();

  Future<bool> requestPermission();

  Future<bool> checkPermission();
}

class LocationService implements AppLocation {
  final defLocation = const EkbLocation();

  @override
  Future<AppLatLong> getCurrentLocation() async {
    return Geolocator.getCurrentPosition()
        .then((value) {
          return AppLatLong(lat: value.latitude, long: value.longitude);
        })
        .catchError((_) => defLocation);
  }

  @override
  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then((value) => value == LocationPermission.always || value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then((value) => value == LocationPermission.always || value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }
}
