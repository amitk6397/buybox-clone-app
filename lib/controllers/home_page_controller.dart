import 'package:buybox_app/route/app_routes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  RxDouble _lati = 0.0.obs;
  RxDouble _long = 0.0.obs;

  RxDouble get lati => _lati;
  RxDouble get long => _long;
  Future<void> getLocation() async {
    try {
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
        _lati.value = currentPosition.latitude;
        _long.value = currentPosition.longitude;

        print(
          'Latitude: ${currentPosition.latitude}, Longitude: ${currentPosition.longitude}',
        );
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          Get.toNamed(AppRoutes.location);
        } else {}
      } else {
        print('Location permission not granted');
      }
    } catch (e) {
      Get.snackbar('Error', '${e.toString()}');
    } finally {}
  }

  // category

  final RxList<String> _categoryImage =
      [
        'assets/category/fruit.jpg',
        'assets/category/vegetable.jpg',
        'assets/category/chiken.jpg',
        'assets/category/items.jpg',
        'assets/category/choco.jpg',
        'assets/category/cloth.png',
        'assets/category/mobile.jpg',
        'assets/category/fruit.jpg',
      ].obs;

  RxList<String> get categoryImage => _categoryImage;

  final RxList<Map<String, dynamic>> _images =
      [
        {'path': 'assets/category/fruit.jpg', 'name': 'Fruits', 'items': '20+'},
        {
          'path': 'assets/category/vegetable.jpg',
          'name': 'Fruits',
          'items': '20+',
        },
        {
          'path': 'assets/category/chiken.jpg',
          'name': 'Fruits',
          'items': '20+',
        },
        {'path': 'assets/category/fruit.jpg', 'name': 'Fruits', 'items': '20+'},
        {'path': 'assets/category/fruit.jpg', 'name': 'Fruits', 'items': '20+'},
        {'path': 'assets/category/fruit.jpg', 'name': 'Fruits', 'items': '20+'},
        {'path': 'assets/category/fruit.jpg', 'name': 'Fruits', 'items': '20+'},
        {'path': 'assets/category/fruit.jpg', 'name': 'Fruits', 'items': '20+'},
      ].obs;
}
