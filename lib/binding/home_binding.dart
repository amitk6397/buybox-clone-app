import 'package:buybox_app/controllers/add_remove_cart_controller.dart';
import 'package:buybox_app/controllers/get_firebasestore_data.dart';
import 'package:buybox_app/controllers/home_page_controller.dart';
import 'package:buybox_app/controllers/image_picker_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/search_items_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => SearchItemsController());
    Get.lazyPut(() => GetFirebasestoreData());
    Get.lazyPut(() => AddRemoveCartController());
  }
}
