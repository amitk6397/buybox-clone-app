import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;
  login(email, password) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user!;
      final document =
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .get();

      // If user doc doesn't exist, create it
      if (!document.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'userName': user.email?.split('@').first ?? 'New User',
          'role': 'user',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      // Fetch user data again after creation
      final data =
          (await _firestore.collection('users').doc(user.uid).get()).data()!;

      if (data['blocked'] == true) {
        Get.snackbar('Access Denied', 'Your account has been blocked.');
        await FirebaseAuth.instance.signOut();
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      String roleName = data['role'];

      final pref = await SharedPreferences.getInstance();
      pref.setString('role', roleName);
      pref.setString('token', userCredential.user!.uid);

      if (roleName == 'admin') {
        Get.offAllNamed(AppRoutes.adminDashboard);
        Get.snackbar(
          "Success",
          "Login Success (Admin)",
          backgroundColor: AppColors.successMessageColor,
        );
      } else {
        Get.offAllNamed(AppRoutes.myHome);
        Get.snackbar(
          "Success",
          "Login Success (User)",
          backgroundColor: AppColors.successMessageColor,
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        '${e.message}',
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

  Future<void> saveUserToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    String uid = FirebaseAuth.instance.currentUser!.uid;

    print('firebase message  = = = = = =fdv==============$token');

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'fcm_token': token,
    });
  }
}
