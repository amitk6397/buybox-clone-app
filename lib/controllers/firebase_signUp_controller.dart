import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseSignupController extends GetxController {
  RxBool isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(String userName, String email, String password) async {
    isLoading.value = true;

    try {
      // final user = await _firestore.collection('users').get();

      String role = 'user';

      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = credential.user!.uid;

      var date =
          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

      var time =
          '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'userName': userName,
        'email': email,
        'date': date,
        'time': time,
        'role': role,
      });

      //navigate

      final document = await _firestore.collection('users').doc(uid).get();

      Map<String, dynamic> userRole = document.data() as Map<String, dynamic>;

      String roleName = userRole['role'];

      if (userRole['role'] == 'admin') {
        final pref = await SharedPreferences.getInstance();
        pref.setString('role', roleName);
        pref.setString('token', uid);
        Get.offAllNamed(AppRoutes.adminDashboard);
        Get.snackbar(
          "Success",
          "Register Success Admin",
          backgroundColor: AppColors.successMessageColor,
        );
      } else {
        final pref = await SharedPreferences.getInstance();
        pref.setString('role', roleName);
        pref.setString('token', uid);

        //

        Get.offAllNamed(AppRoutes.myHome);

        Get.snackbar(
          "Success",
          "Register Success user",
          backgroundColor: AppColors.successMessageColor,
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Unknown error occurred');
    } finally {
      isLoading.value = false;
    }
  }
}
