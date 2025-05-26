import 'package:buybox_app/route/app_routes.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  RxDouble _lati = 0.0.obs;
  RxDouble _long = 0.0.obs;

  RxDouble get lati => _lati;
  RxDouble get long => _long;

  RxString _address = ''.obs;
  RxString get address => _address;

  RxString _city = ''.obs;
  RxString get city => _city;

  Future<void> getLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      LocationPermission permission = await Geolocator.checkPermission();

      prefs.setBool('location', permission == LocationPermission.denied);

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
        _lati.value = currentPosition.latitude;
        _long.value = currentPosition.longitude;

        List<Placemark> placeMark = await placemarkFromCoordinates(
          currentPosition.latitude,
          currentPosition.longitude,
        );

        if (placeMark.isNotEmpty) {
          Placemark place = placeMark.first;
          address.value =
              "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
          _city.value = place.locality.toString();
        }

        print(
          'Latitude: ${currentPosition.latitude}, Longitude: ${currentPosition.longitude}',
        );
      } else {
        print('Location permission not granted');
      }
    } catch (e) {
      Get.snackbar('Error', '${e.toString()}');
    } finally {}
  }

  // category

  final RxList<Map<String, dynamic>> categoryImage =
      [
        {
          'path': 'assets/category/fruit.jpg',
          'name': 'Fruits',
          'items': '20+ Items',
        },
        {
          'path': 'assets/category/vegetable.jpg',
          'name': 'Vegetables',
          'items': '30+ Items',
        },
        {
          'path': 'assets/category/chiken.jpg',
          'name': 'Chicken',
          'items': '18+ Items',
        },
        {
          'path': 'assets/category/choco.jpg',
          'name': 'Chocolates',
          'items': '25+ Items',
        },
        {
          'path': 'assets/category/items.jpg',
          'name': 'Atta, Rice, Oil',
          'items': '100+ Items',
        },
        {
          'path': 'assets/category/cloth.png',
          'name': 'Clothes',
          'items': '30+ Items',
        },
        {
          'path': 'assets/category/mobile.jpg',
          'name': 'Mobiles',
          'items': '50+ Items',
        },
        {
          'path': 'assets/category/shoes.jpg',
          'name': 'Shoes',
          'items': '50+ Items',
        },
        {
          'path': 'assets/category/watch.webp',
          'name': 'Watchs',
          'items': '30+ Items',
        },
        {
          'path': 'assets/category/others.jpg',
          'name': 'Others',
          'items': '200+ Items',
        },
      ].obs;
}
