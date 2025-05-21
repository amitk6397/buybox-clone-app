import 'package:buybox_app/models/response_models/search_response_model.dart';
import 'package:buybox_app/services/search_auth.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:get/get.dart';

class SearchItemsController extends GetxController {
  final _auth = SearchAuth();
  RxBool isLoading = false.obs;
  final RxList<Products> _product = <Products>[].obs;
  RxList<Products> get product => _product;

  Future<void> fetchData(String query) async {
    isLoading.value = true;

    try {
      final response = await _auth.fetchData(query);

      _product.assignAll(response);
      print('Pesponse == = = = = = = = $response');
    } catch (e) {
      print('error mx kjn = = = = = = = = =  $e');
      Get.snackbar(
        'Error',
        '${e.toString()}',
        backgroundColor: AppColors.errorMessageColor,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
