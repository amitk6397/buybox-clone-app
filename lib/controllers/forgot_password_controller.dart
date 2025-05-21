import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> forgotPassword(String email) async {
    isLoading.value = true;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar('Forgot Password', 'Please go to email and reset Password');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', '${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
