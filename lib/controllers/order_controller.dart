import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/views/order/address_screen.dart';
import 'package:buybox_app/views/order/payment_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  RxBool _isflag = false.obs;

  RxBool get isFlag => _isflag;

  void changeWidget(value) {
    _isflag.value = value;

    print(' === == = $isFlag');
  }

  final RxList<Widget> _widgetChange =
      <Widget>[firstWidget(), secondWidget(), threeWidget()].obs;

  RxList<Widget> get widgetChange => _widgetChange;

  RxInt _index = 0.obs;
  RxInt get index => _index;

  void addIndex(index) {
    _index.value = index;
  }

  // Store date in fireStore

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeData(
    String name,
    String email,
    String phone,
    String address,
    String code,
    String city,
    String country,
  ) async {
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;

      _firestore.collection('users').doc(uid).collection('addresses').add({
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'code': code,
        'city': city,
        'country': country,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      Get.snackbar(
        'Address',
        'Not save',
        backgroundColor: AppColors.errorMessageColor,
      );
    }
  }
}
