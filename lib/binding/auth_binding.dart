import 'package:buybox_app/controllers/firebase_auth_controller.dart';
import 'package:buybox_app/controllers/firebase_signUp_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseAuthController());
    Get.lazyPut(() => FirebaseSignupController());
  }
}
