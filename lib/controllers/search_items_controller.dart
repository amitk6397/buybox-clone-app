import 'package:buybox_app/models/response_models/search_response_model.dart';
import 'package:buybox_app/services/db_helper.dart';
import 'package:buybox_app/services/search_auth.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class SearchItemsController extends GetxController {
  final _auth = SearchAuth();
  RxBool isLoading = false.obs;
  final RxList<Products> _product = <Products>[].obs;
  RxList<Products> get product => _product;

  RxBool _isChange = false.obs;

  RxBool get isChange => _isChange;

  // DBHelper? dbRef;

  void itemChange() {
    if (_isChange.value) {
      _isChange.value = false;
    }
  }

  Future<void> fetchData(String query) async {
    isLoading.value = true;
    // dbRef = DBHelper(TABLE_NAME: query);
    try {
      final response = await _auth.fetchData(query);
      if (!response.contains(_product)) {
        _product.assignAll(response);
        // response.map((item) {
        //   dbRef!.addData(
        //     id: item.asin,
        //     title: item.productTitle,
        //     image: item.productPhoto,
        //     price: item.productPrice,
        //     originPrice: item.productOriginalPrice,
        //     unitCount: item.unitCount.toString(),
        //     salesVolume: item.salesVolume,
        //   );
        // }).toList();
      }
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

  Future<void> saveUserToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    String uid = FirebaseAuth.instance.currentUser!.uid;

    print(
      'firebase message  = = = = = =fdv==============$uid = = = = $token  ',
    );

    // await FirebaseFirestore.instance.collection('users').doc(uid).update({
    //   'fcm_token': token,
    // });
  }
}
