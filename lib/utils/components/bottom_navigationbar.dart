import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/views/home/home_screen.dart';
import 'package:buybox_app/views/profile/profiel_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//final NavigationbarController _controller = Get.put(NavigationbarController());

Widget bottomNavigationBar(NavigationbarController _controller) {
  return BottomAppBar(
    color: AppColors.white,
    padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        bottomIcon(Icons.home, 0, _controller),
        bottomIcon(Icons.sync_alt, 1, _controller),
        GestureDetector(
          onTap: () {
            _controller.changeScreen(2);
          },
          child: CircleAvatar(
            backgroundColor: AppColors.green,
            radius: 35,
            child: Icon(Icons.shopping_cart, color: AppColors.white, size: 25),
          ),
        ),
        bottomIcon(Icons.favorite, 3, _controller),
        GestureDetector(
          onTap: () {
            _controller.changeScreen(4);
          },
          child: CircleAvatar(
            backgroundColor: AppColors.grey,
            radius: 15,
            // child: Icon(Icons.shopping_cart, color: AppColors.white, size: 25),
          ),
        ),
      ],
    ),
  );
}

Widget bottomIcon(
  IconData icon,
  int index,
  NavigationbarController _controller,
) {
  return GestureDetector(
    onTap: () {
      _controller.changeScreen(index);
    },
    child: Obx(
      () => Icon(
        size: 28,

        icon,
        color: _controller.index == index ? AppColors.green : AppColors.grey,
      ),
    ),
  );
}
