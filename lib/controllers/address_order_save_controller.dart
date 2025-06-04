import 'package:buybox_app/controllers/add_remove_cart_controller.dart';
import 'package:buybox_app/models/request_models/order_request_model.dart';
import 'package:buybox_app/services/notification_service.dart';
import 'package:buybox_app/services/send_notification_service.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressOrderSaveController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  NotificationService notificationService = NotificationService();

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

      await _firestore
          .collection('users')
          .doc(userToken)
          .collection('notifications')
          .add({
            'title':
                'Order Successfully placed  ${prefs.getString('userName')}',
            'body': orderItems[0].name,
            'image': orderItems[0].image,
            'isSeen': false,
            'total': total.toDouble(),
            'orderId': orderId,
            'createAt': DateTime.now(),
          });

      SendNotificationService.sendNotificationMessage(
        title: orderItems[0].name,
        body: 'Order Successfully placed  ${prefs.getString('userName')}',
        data: {'screen': 'notification_screen'},
      );

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
