import 'package:buybox_app/controllers/serach_screen_item_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SerachScreenItemController());
  }
}
