import 'package:buybox_app/route/app_routes.dart';
import 'package:get/get.dart';

class StartAppController extends GetxController {
  final RxList<String> _images =
      [
        'assets/images/bag.avif',
        'assets/images/girlbag.jpg',
        'assets/images/young.avif',
      ].obs;

  RxList<String> get images => _images;
  RxInt _index = 0.obs;

  RxInt get index => _index;

  void addIndex() {
    if (_images.length - 1 == _index.value) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      _index.value += 1;
      print(index);
    }
  }
}
