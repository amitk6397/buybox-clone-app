import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:buybox_app/views/admin/admin_order_page.dart';
import 'package:buybox_app/views/admin/dashboard_screen.dart';
import 'package:buybox_app/views/admin/food_order_screen.dart';
import 'package:buybox_app/views/admin/items_menu_screen.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDrawerController extends GetxController {
  final RxInt _index = 0.obs;
  RxInt get index => _index;

  void indexValue(value) {
    _index.value = value;
  }

  RxList<Widget> drawerScreen =
      [
        DashboardScreen(),
        ItemsMenuScreen(),
        FoodOrderScreen(),
        AdminOrderPage(),
      ].obs;

  RxList<String> drawerName = ['Dashboard', 'Menu', 'Food Order', 'Order'].obs;

  //Fetch admin pannel

  RxList<Map<String, dynamic>> _adminData = <Map<String, dynamic>>[].obs;

  RxList<Map<String, dynamic>> get adminData => _adminData;

  Future<void> listOfUsers() async {
    try {
      final users =
          await FirebaseFirestore.instance
              .collection('users')
              .where('role', isEqualTo: 'admin')
              .get();

      List<Map<String, dynamic>> userData =
          users.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

      _adminData.value = userData;
    } catch (e) {
      Get.snackbar(
        'Error',
        '${e.toString()}',
        backgroundColor: AppColors.errorMessageColor,
      );
      print(e);
    } finally {}
  }
}
