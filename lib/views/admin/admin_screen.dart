import 'package:buybox_app/controllers/admin_controller/admin_drawer_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/views/admin/drawer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final AdminDrawerController _controller = Get.put(AdminDrawerController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.listOfUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(controller: _controller),

      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.white, size: 25),
        backgroundColor: AppColors.green,
        title: Obx(
          () => Text(
            _controller.drawerName[_controller.index.value],
            style: TextStyle(
              fontSize: 20,

              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
      ),
      body: Obx(() => _controller.drawerScreen[_controller.index.value]),
    );
  }
}
