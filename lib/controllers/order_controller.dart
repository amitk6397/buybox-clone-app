import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/views/order/address_screen.dart';
import 'package:buybox_app/views/order/payment_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  // change Widget

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
  var uid = FirebaseAuth.instance.currentUser!.uid;

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
      //Store data

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

      // get data
    } catch (e) {
      Get.snackbar(
        'Address',
        'Not save',
        backgroundColor: AppColors.errorMessageColor,
      );
    }
  }

  // get data
  RxList<Map<String, dynamic>> _getAddress = <Map<String, dynamic>>[].obs;

  RxList<Map<String, dynamic>> get getAddress => _getAddress;

  Future<void> getData() async {
    try {
      final document =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('addresses')
              .orderBy('createdAt', descending: true)
              .get();

      if (document.docs.isNotEmpty) {
        _getAddress.value = document.docs.map((doc) => doc.data()).toList();
        print('getAddress == == $getAddress');
      } else {
        print('Document is not exists');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        '${e.toString()}',
        backgroundColor: AppColors.errorMessageColor,
      );
    }
  }

  //save address

  RxBool _isSava = false.obs;

  RxBool get isSava => _isSava;

  void saveData() {
    isSava.value = !isSava.value;

    print('isSava === == = $isSava');
  }

  // select address

  RxInt _selectIndex = 0.obs;
  RxInt get selectIndex => _selectIndex;

  void selectAddress(index) {
    _selectIndex.value = index;
  }
}
