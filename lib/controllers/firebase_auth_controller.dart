import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthController extends GetxController {
  RxString token = ''.obs;

  RxBool isLoading = false.obs;
  login(email, password) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user?.uid != null) {
        token.value = userCredential.user!.uid;

        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('token', token.toString());

        Get.offAllNamed(AppRoutes.myHome);

        Get.snackbar(
          'Success',
          'Login Success',
          backgroundColor: AppColors.successMessageColor,
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        '${e.toString()}',
        backgroundColor: AppColors.errorMessageColor,
      );
      print(e);
    } finally {
      isLoading.value = false;
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

      final UserCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final pref = await SharedPreferences.getInstance();
      pref.setString('token', UserCredential.user!.uid);
      Get.offAllNamed(AppRoutes.myHome);
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
