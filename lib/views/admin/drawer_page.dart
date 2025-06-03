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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/cooking_background.webp'),
                    opacity: 0.3,
                    fit: BoxFit.cover,
                  ),
                  color: Colors.grey.shade200,
                ),
                accountName: Text(
                  controller.adminData[0]['userName'] ?? 'Admin Name',
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                accountEmail: Text(
                  controller.adminData[0]['email'] ?? 'Admin email',
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/login_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
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
    child: Padding(
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 2),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:
              controller.index.value == index
                  ? AppColors.yellow
                  : AppColors.white,
        ),
        child: ListTile(
          leading: Icon(
            logo,
            color:
                controller.index.value == index
                    ? AppColors.white
                    : AppColors.grey,
          ),
          title: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color:
                  controller.index.value == index
                      ? AppColors.white
                      : AppColors.grey,
            ),
          ),
          trailing: Icon(
            icon,
            size: 25,
            color:
                controller.index.value == index
                    ? AppColors.white
                    : AppColors.grey,
          ),
        ),
      ),
    ),
  );
}
