import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/order_controller.dart';
import 'package:get/get.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => NavigationbarController());
  }
}
