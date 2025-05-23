import 'dart:async';
import 'dart:math';

import 'package:buybox_app/controllers/home_page_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final HomePageController _controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: appBackButton(AppColors.white, Icons.arrow_back, () async {
          final prefs = await SharedPreferences.getInstance();
          if (prefs.getString('address') == null) {
            Get.snackbar(
              'Location',
              "Please click confirm \$ continue button",
              backgroundColor: AppColors.errorMessageColor,
            );
          } else {
            Get.back();
          }
        }),
        title: Text('Location', style: appBarText()),
        backgroundColor: AppColors.green,
      ),
      body: Obx(() {
        if (_controller.lati == 0.0 || _controller.long == 0.0) {
          return const Center(child: CircularProgressIndicator());
        }
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
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
                ),
              ],
            ),
            Positioned(
              bottom: 25,
              left: 25,
              child: Container(
                width: mediaQuery.width * 0.7,
                height: mediaQuery.height * 0.2,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 2,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _controller.city.value,
                        style: TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(_controller.address.value),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('address', _controller.address.value);
                          Get.offAndToNamed(AppRoutes.myHome);
                          Get.snackbar(
                            "Addrress",
                            'Successful Save your Location',
                            backgroundColor: AppColors.successMessageColor,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "CONFIRM & CONTINUE",
                              style: TextStyle(
                                letterSpacing: 1,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
