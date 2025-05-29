import 'package:buybox_app/models/response_models/fruits_response_model.dart';
import 'package:buybox_app/services/fruits_service.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:get/get.dart';

class FruitsJsonController extends GetxController {
  RxList<FruitsResponseModel> _listData = <FruitsResponseModel>[].obs;

  RxList<FruitsResponseModel> get listData => _listData;

  final _fruitsAuth = FruitsService();

  RxBool _isChange = false.obs;

  RxBool get isChange => _isChange;

  void itemChange(value) {
    _isChange.value = value;
  }

  Future<void> getData() async {
    try {
      final response = await _fruitsAuth.getData();
      _listData.addAll(response);
      print('== titl ${_listData[0].title}');
      print(_isChange.value);
    } catch (e) {
      Get.snackbar(
        'Error',
        '${e.toString()}',
        backgroundColor: AppColors.errorMessageColor,
      );
    }
  }
}
