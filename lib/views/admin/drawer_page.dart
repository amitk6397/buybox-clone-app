import 'package:buybox_app/controllers/admin_controller/admin_drawer_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatelessWidget {
  AdminDrawerController controller;
  DrawerPage({required this.controller});

  signOut() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getString('role') == 'admin') {
      pref.clear();

      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      shadowColor: Colors.grey,
      width: 250,
      child: Obx(
        () => ListView(
          padding: EdgeInsets.all(0),
          children: [
            Obx(() {
              return UserAccountsDrawerHeader(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(color: Colors.grey.shade200),
                accountName: Text(
                  controller.adminData[0]['userName'] ?? 'Admin Name',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                accountEmail: Text(
                  controller.adminData[0]['email'] ?? 'Admin email',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                currentAccountPicture: CircleAvatar(),
              );
            }),
            listTileDrawer(
              Icons.dashboard,

              'DashBoard',
              () {
                controller.indexValue(0);
              },
              Icons.arrow_right,
              controller,
              0,
            ),

            listTileDrawer(
              Icons.menu_book,

              'Menu',
              () {
                controller.indexValue(1);
              },
              Icons.arrow_right,
              controller,
              1,
            ),

            listTileDrawer(
              Icons.food_bank,

              'FoodOrder',
              () {
                controller.indexValue(2);
              },
              Icons.arrow_right,
              controller,
              2,
            ),

            listTileDrawer(
              Icons.shopping_bag,

              'Order',
              () {
                controller.indexValue(3);
              },
              Icons.arrow_right,
              controller,
              3,
            ),

            listTileDrawer(
              Icons.settings,

              'Setting',
              () {},
              Icons.arrow_right,
              controller,
              4,
            ),
            listTileDrawer(
              Icons.logout,

              'LogOut',
              () {
                signOut();
              },
              Icons.arrow_right,
              controller,
              5,
            ),
          ],
        ),
      ),
    );
  }
}

Widget listTileDrawer(
  IconData logo,
  String label,
  VoidCallback onTap,
  IconData icon,
  AdminDrawerController controller,
  int index,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:
            controller.index.value == index
                ? Colors.grey.shade300
                : AppColors.white,
      ),
      child: ListTile(
        leading: Icon(
          logo,
          color:
              controller.index.value == index
                  ? AppColors.green
                  : AppColors.grey,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color:
                controller.index.value == index
                    ? AppColors.green
                    : AppColors.grey,
          ),
        ),
        trailing: Icon(
          icon,
          size: 25,
          color:
              controller.index.value == index
                  ? AppColors.green
                  : AppColors.grey,
        ),
      ),
    ),
  );
}
