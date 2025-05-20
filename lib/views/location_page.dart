import 'package:buybox_app/controllers/home_page_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final HomePageController _controller = Get.find();

  // LatLng currentLocation = LatLng(_controller.lati.toDouble(), _controller..toDouble(), );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location'), backgroundColor: AppColors.green),
      body: Obx(() {
        if (_controller.lati == 0.0 || _controller.long == 0.0) {
          return const Center(child: CircularProgressIndicator());
        }

        print(
          'location === == = == ${_controller.lati.toDouble()} lksk == ${_controller.long.toDouble()}',
        );
        return SizedBox.expand(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              zoom: 13,
              target: LatLng(
                _controller.lati.toDouble(),
                _controller.long.toDouble(),
              ),
            ),
            markers: {
              Marker(
                markerId: MarkerId('current location'),
                icon: BitmapDescriptor.defaultMarker,
                position: LatLng(
                  _controller.lati.toDouble(),
                  _controller.long.toDouble(),
                ),
              ),
            },
          ),
        );
      }),
    );
  }
}
