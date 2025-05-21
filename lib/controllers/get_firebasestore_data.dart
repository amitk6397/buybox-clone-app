import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetFirebasestoreData extends GetxController {
  RxString _name = ''.obs;
  RxString get name => _name;

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('token') ?? 'User';

    print('Uid ==== uid ==== uid   ====== $uid');

    try {
      final document =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (document.exists) {
        Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
        _name.value = userData['userName'];
        print('userdata == === ========= ${userData['userName']}');
      } else {
        print('Document is not exists');
      }
    } catch (e) {
      print('kdsjd Error  == ==  ${e.toString()}');
    }
  }
}
