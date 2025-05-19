import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthController extends GetxController {
  RxBool isLoading = false.obs;
  login(email, password) async {
    isLoading.value = true;
    print(' =  = = = = = = = == == = ${isLoading.value}');
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        Get.offAllNamed('/home');
        Get.snackbar(
          'Success',
          'Login Success',
          backgroundColor: AppColors.successMessageColor,
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        'Login Faied',
        backgroundColor: AppColors.errorMessageColor,
      );
    } finally {
      isLoading.value = false;
      print('finally =  = = = = = = = == == = ${isLoading.value}');
    }
  }

  googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAllNamed('/home');
      Get.snackbar(
        'Success',
        'Login Success',
        backgroundColor: AppColors.successMessageColor,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        '${e.toString()}',
        backgroundColor: AppColors.errorMessageColor,
      );
    }
  }
}
