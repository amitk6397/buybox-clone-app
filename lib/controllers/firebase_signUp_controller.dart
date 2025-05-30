import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseSignupController extends GetxController {
  RxBool isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(String userName, String email, String password) async {
    isLoading.value = true;

    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = credential.user!.uid;

      final pref = await SharedPreferences.getInstance();
      pref.setString('token', uid);

      await _firestore.collection('users').doc(uid).set({'userName': userName});

      //navigate

      if(userName == 'Amit kumar'){
        
      }else{
        Get.offAllNamed(AppRoutes.myHome);
      }

      Get.offAllNamed(AppRoutes.myHome);

      Get.snackbar(
        "Success",
        "Register Success",
        backgroundColor: AppColors.successMessageColor,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Unknown error occurred');
    } finally {
      isLoading.value = false;
    }
  }
}
