import 'package:buybox_app/controllers/home_page_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationbarController());
    Get.lazyPut(() => HomePageController());
  }
}
