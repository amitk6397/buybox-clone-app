import 'package:buybox_app/models/request_models/cart_request_model.dart';
import 'package:get/get.dart';

class AddRemoveCartController extends GetxController {
  RxList<CartRequestModel> _cartItems = <CartRequestModel>[].obs;

  RxList<CartRequestModel> get cartItems => _cartItems;

  void addCartItems(int index, String title, String price, String image) {
    _cartItems.add(
      CartRequestModel(index: index, title: title, price: price, image: image),
    );
  }
}
