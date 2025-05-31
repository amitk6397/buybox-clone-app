import 'package:buybox_app/models/request_models/order_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressOrderSaveController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<void> addOrderInFirebase()async{
  //     try{
  //       final prefs = await SharedPreferences.getInstance();

  //       await _firestore.collection('users').doc(prefs.getString('token')).collection('orders').add(

  //       )
  //     }
  // }
}
