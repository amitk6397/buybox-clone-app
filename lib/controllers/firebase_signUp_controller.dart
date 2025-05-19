import 'package:buybox_app/route/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseSignupController extends GetxController {
  RxBool isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(String userName, String email, String password) async {
    isLoading.value = true;

    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = credential.user!.uid;

      await _firestore.collection('users').doc(uid).set({'userName': userName});

      //navigate

      Get.offAllNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Unknown error occurred');
    } finally {
      isLoading.value = false;
    }
  }
}
