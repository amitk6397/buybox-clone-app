import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  var notificationCount = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchNotificationCount();
  }

  void fetchNotificationCount() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('notifications')
        .where('isSeen', isEqualTo: false)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
          notificationCount.value = querySnapshot.docs.length;
          update();
        });
  }

  Future<void> deletedById(String uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('notifications')
        .doc(uid)
        .delete();
  }
}
