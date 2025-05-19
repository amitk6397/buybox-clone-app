import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print('Location permission denied');
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // Use locationSettings instead of deprecated desiredAccuracy
      final locationSettings = LocationSettings(
        accuracy: LocationAccuracy.best,
      );

      Position currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      print(
        'Latitude: ${currentPosition.latitude}, Longitude: ${currentPosition.longitude}',
      );
    } else {
      print('Location permission not granted');
    }
  }
}
