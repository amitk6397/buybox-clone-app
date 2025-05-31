import 'package:buybox_app/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:cloud_functions/cloud_functions.dart';

class DashboardController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<bool> showStates = <bool>[].obs;

  RxList<Map<String, dynamic>> _userList = <Map<String, dynamic>>[].obs;

  RxList<Map<String, dynamic>> get userList => _userList;

  Future<void> listOfUsers() async {
    isLoading.value = true;
    try {
      final users =
          await FirebaseFirestore.instance
              .collection('users')
              .where('role', isNotEqualTo: 'admin')
              .get();

      List<Map<String, dynamic>> userData =
          users.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

      _userList.value = userData;
      showStates.value = List.generate(userData.length, (_) => false);
    } catch (e) {
      Get.snackbar(
        'Error',
        '${e.toString()}',
        backgroundColor: AppColors.errorMessageColor,
      );
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void toggleVisibility(int index) {
    showStates[index] = !showStates[index];
    showStates.refresh();
  }

  // delete user Account

  Future<void> deleteUserByAdmin(String uid) async {
    try {
      isLoading.value = true;
      final callable = FirebaseFunctions.instance.httpsCallable(
        'deleteUserAccount',
      );
      final result = await callable.call({'uid': uid});

      Get.snackbar('Success', result.data['message']);

      // Refresh the user list after deletion
      await listOfUsers();
    } on FirebaseFunctionsException catch (e) {
      Get.snackbar(
        'Error',
        '$uid = = = =${e.message}' ?? 'Function failed',
        backgroundColor: AppColors.errorMessageColor,
      );
      print('$uid ==   ${e.message}');
    } catch (e) {
      print('error  = = = = = ${e.toString()}');
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: AppColors.errorMessageColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Block

  Future<void> blockUser(String uid, bool block) async {
    try {
      isLoading.value = true;

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'blocked': block,
      });

      Get.snackbar(
        'Success',
        block ? 'User blocked successfully.' : 'User unblocked successfully.',
        backgroundColor: AppColors.successMessageColor,
      );

      // Refresh user list
      await listOfUsers();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: AppColors.errorMessageColor,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
