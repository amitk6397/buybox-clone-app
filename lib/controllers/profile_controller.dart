import 'package:buybox_app/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  RxString _date = ''.obs;
  RxString _gender = ''.obs;

  RxString get date => _date;
  RxString get gender => _gender;

  RxString _address = ''.obs;

  RxString get address => _address;

  Future<void> setDate(String date) async {
    _date.value = date;
    print(date);
  }

  Future<void> setGender(String gender) async {
    _gender.value = gender;
    print(gender);
  }

  void getAddress(String address) async {
    _address.value = address;
    print(' Address = = = = = =$address');
  }

  Future<void> changeName(String name) async {
    try {
      print('name  == = = = = $name');
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final _firestore = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'userName': name});
      Get.snackbar(
        "Success",
        "User info updated",
        backgroundColor: AppColors.ligthGreen,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: AppColors.errorMessageColor,
      );
    }
  }
}
