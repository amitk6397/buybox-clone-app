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
}
