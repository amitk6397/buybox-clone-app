import 'package:buybox_app/models/request_models/cart_request_model.dart';
import 'package:buybox_app/models/request_models/fav_item_request_model.dart';
import 'package:get/get.dart';

class AddRemoveCartController extends GetxController {
  RxInt _counter = 0.obs;
  RxInt get counter => _counter;

  final RxList<CartRequestModel> _cartItems = <CartRequestModel>[].obs;

  RxList<CartRequestModel> get cartItems => _cartItems;

  final RxMap<String, dynamic> _itemCounts = <String, dynamic>{}.obs;
  RxMap<String, dynamic> get itemCounts => _itemCounts;

  //addCartItems

  void addCartItems(String id, String title, String price, String image) {
    _counter.value++;
    _cartItems.add(
      CartRequestModel(id: id, title: title, price: price, image: image),
    );
  }

  //removeCartitems

  void removeCartItem(String id) {
    CartRequestModel? removedItem = _cartItems.firstWhere(
      (item) => item.id == id,
    );
    _cartItems.remove(removedItem);
    _counter.value--;
  }

  int getCount(String id) {
    return _itemCounts[id] ?? 0;
  }

  void addItem(String id) {
    if (_itemCounts.containsKey(id)) {
      _itemCounts[id] = _itemCounts[id]! + 1;
    } else {
      _itemCounts[id] = 1;
    }
  }

  // Remove item from the cart
  void removeItem(String id) {
    if (_itemCounts.containsKey(id) && _itemCounts[id]! > 0) {
      _itemCounts[id] = _itemCounts[id]! - 1;
      if (_itemCounts[id] == 0) {
        _itemCounts.remove(id);
        _cartItems.removeWhere((item) => item.id == id);
      }
    }
  }

  //Total price

  RxDouble get totalPrice {
    RxDouble total = 0.0.obs;
    for (var item in _cartItems) {
      final count = _itemCounts[item.id] ?? 0;

      final price =
          double.tryParse(
            item.price.replaceAll('₹', '').replaceAll(',', '').trim(),
          ) ??
          0.0;

      total.value += price * count;
    }
    return total;
  }

  //Favorites item

  final RxList<FavItemRequestModel> _favItems = <FavItemRequestModel>[].obs;

  RxList<FavItemRequestModel> get favItems => _favItems;

  void favItemToggle(String id, String title, String price, String image) {
    final existing = _favItems.indexWhere((item) => item.id == id);
    if (existing == -1) {
      _favItems.add(
        FavItemRequestModel(id: id, title: title, price: price, image: image),
      );
    } else {
      _favItems.removeAt(existing);
    }
  }

  void removeFavItem(String id) {
    _favItems.removeWhere((item) => item.id == id);
  }

  bool isFav(String id) {
    return _favItems.any((item) => item.id == id);
  }
}
