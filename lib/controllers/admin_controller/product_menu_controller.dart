import 'package:buybox_app/services/db_helper.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:get/get.dart';

class ProductMenuContoller extends GetxController {
  RxList<Map<String, dynamic>> _itemList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> get itemList => _itemList;

  DBHelper? dbRef;

  Future<void> getStoreData(String tableName) async {
    dbRef = DBHelper(TABLE_NAME: tableName);
    try {
      final list = await dbRef!.getAllData(tableName);
      _itemList.value = list;
    } catch (e) {
      Get.snackbar(
        "Error",
        '${e.toString()}',
        backgroundColor: AppColors.errorMessageColor,
      );
    }
  }
}
