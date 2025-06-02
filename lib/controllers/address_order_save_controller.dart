import 'package:buybox_app/controllers/add_remove_cart_controller.dart';
import 'package:buybox_app/models/request_models/order_request_model.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressOrderSaveController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final AddRemoveCartController _controller = Get.find();

  RxList<OrderItem> _items = <OrderItem>[].obs;

  RxList<OrderItem> get items => _items;

  Future<void> addOrderInFirebase() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userToken = prefs.getString('token');

      if (userToken == null) {
        throw Exception("User token not found in SharedPreferences");
      }

      final orderId = 'order_${DateTime.now().microsecondsSinceEpoch}';

      List<OrderItem> orderItems =
          _controller.cartItems.map((cartItem) {
            final quantity = _controller.getCount(cartItem.id);
            return OrderItem(
              itemId: cartItem.id,
              name: cartItem.title,
              image: cartItem.image,
              price: cartItem.price,
              quantity: quantity,
            );
          }).toList();

      var total = _controller.totalPrice;

      final order = OrderRequestModel(
        orderId: orderId,
        userId: userToken,
        items: orderItems,
        total: total.toDouble(),
        status: 'pending',
        timestamp: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(userToken)
          .collection('orders')
          .add(order.toMap());

      Get.snackbar(
        'Success',
        'Thank you for order',
        backgroundColor: AppColors.successMessageColor,
      );
    } catch (e) {
      print("Error adding order to Firebase: $e");
    }
  }
}
