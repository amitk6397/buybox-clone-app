import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/profile_controller.dart';
import 'package:buybox_app/views/profile/personalInfo_page.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
