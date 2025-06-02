import 'package:buybox_app/controllers/admin_controller/dashboard_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FoodOrderController extends GetxController {
  //final DashboardController _controller = Get.put(DashboardController());

  RxList<Map<String, dynamic>> _userOrder = <Map<String, dynamic>>[].obs;

  RxList<Map<String, dynamic>> get userOrder => _userOrder;

  final firestore = FirebaseFirestore.instance;

  Future<void> userFoodOrder() async {
    _userOrder.clear();

    try {
      final document = await firestore.collection('users').get();

      for (var userDoc in document.docs) {
        final userUid = userDoc.id;

        if (userUid == 'admin') continue;

        final ordersSnapshot =
            await firestore
                .collection('users')
                .doc(userUid)
                .collection('orders')
                .get();

        for (var orderDoc in ordersSnapshot.docs) {
          final data = orderDoc.data();

          _userOrder.add({...data, 'orderId': orderDoc.id, 'userId': userUid});
        }
      }
    } catch (e) {
      Get.snackbar('Error', '${e.toString()}');
    }
  }

  //Delete

  Future<void> deletedOrder(String uid, String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('orders')
          .doc(userId)
          .delete();

      Get.snackbar(
        'Success',
        'Cancel your order',
        backgroundColor: AppColors.successMessageColor,
      );
    } catch (e) {
      Get.snackbar(
        'Errro',
        'Not Cancel your order',
        backgroundColor: AppColors.errorMessageColor,
      );
    }
  }

  // confirm your order

  RxMap<String, bool> loadingStates = <String, bool>{}.obs;

  Future<void> confrimOrder(String uid, String orderId, String status) async {
    loadingStates[orderId] = true;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('orders')
          .doc(orderId)
          .update({'status': status});

      final index = _userOrder.indexWhere(
        (order) => order['userId'] == uid && order['orderId'] == orderId,
      );
      if (index != -1) {
        _userOrder[index]['status'] = status;
        _userOrder.refresh();
      }

      Get.snackbar(
        'Success',
        'Confirm your order',
        backgroundColor: AppColors.successMessageColor,
      );
    } catch (e) {
      Get.snackbar(
        'Errro',
        '$uid',
        backgroundColor: AppColors.errorMessageColor,
      );
    } finally {
      loadingStates[orderId] = false;
    }
  }

  // Order page

  RxList<Map<String, dynamic>> checkStatus = <Map<String, dynamic>>[].obs;

  Future<void> onlyConfirmOrder() async {
    try {
      checkStatus.clear();
      final document = await firestore.collection('users').get();

      for (var userDoc in document.docs) {
        final userUid = userDoc.id;

        if (userUid == 'admin') continue;

        final ordersSnapshot =
            await firestore
                .collection('users')
                .doc(userUid)
                .collection('orders')
                .get();

        for (var orderDoc in ordersSnapshot.docs) {
          final data = orderDoc.data();
          final status = data['status'];
          final orderId = orderDoc.id;

          if (status == 'confirm') {
            checkStatus.add({
              'userId': userUid,
              'orderId': orderId,
              'status': status,
            });
          }
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch order statuses',
        backgroundColor: AppColors.errorMessageColor,
      );
    }
  }
}
