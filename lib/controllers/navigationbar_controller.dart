import 'package:get/get.dart';

class NavigationbarController extends GetxController {
  RxInt _index = 0.obs;

  RxInt get index => _index;

  void changeScreen(value) {
    _index.value = value;
  }
}
