import 'dart:io';

import 'package:buybox_app/controllers/admin_controller/dashboard_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:buybox_app/controllers/admin_controller/food_order_controller.dart';

class FoodOrderScreen extends StatefulWidget {
  const FoodOrderScreen({super.key});

  @override
  State<FoodOrderScreen> createState() => _FoodOrderScreenState();
}

class _FoodOrderScreenState extends State<FoodOrderScreen> {
  final DashboardController _controller1 = Get.put(DashboardController());
  final FoodOrderController _controller = Get.put(FoodOrderController());

  @override
  void initState() {
    super.initState();
    _controller1.listOfUsers();
    _controller.userFoodOrder(); // Fetch all user orders
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final Map<String, List<Map<String, dynamic>>> groupedOrders = {};

        for (var order in _controller.userOrder) {
          final userId = order['userId'];
          final orderId = order['orderId'];
          final items = order['items'] as List<dynamic>?;

          if (items != null) {
            for (var item in items) {
              if (item is Map<String, dynamic>) {
                final enrichedItem = {
                  ...item,
                  'userId': userId,
                  'orderId': orderId,
                };
                groupedOrders.putIfAbsent(userId, () => []).add(enrichedItem);
              }
            }
          }
        }

        if (groupedOrders.isEmpty) {
          return const Center(child: Text('No ordered products found.'));
        }

        return ListView.builder(
          itemCount: _controller1.userList.length,
          itemBuilder: (context, index) {
            final user = _controller1.userList[index];
            final userId = user['uid'];

            final userOrders = groupedOrders[userId];
            if (userOrders == null || userOrders.isEmpty)
              return const SizedBox();

            return Obx(
              () => Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading:
                          user['image'] != null
                              ? Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                    image: FileImage(File(user['image'])),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                              : Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    user['userName']?.isNotEmpty == true
                                        ? user['userName'][0].toUpperCase()
                                        : '?',
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                      title: Text(
                        user['userName'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(user['email'] ?? ''),
                      trailing: GestureDetector(
                        onTap: () {
                          _controller1.toggleVisibility(index);
                        },
                        child: const Icon(Icons.arrow_drop_down),
                      ),
                    ),

                    // List of that user's orders
                    if (_controller1.userList[index]['isVisible'] == true)
                      Column(
                        children:
                            userOrders.map((item) {
                              return ListTile(
                                title: Text(
                                  item['name'] ?? 'No name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    row(
                                      'Price',
                                      ' ${item['price']}',
                                      AppColors.grey,
                                      AppColors.ligthGreen,
                                    ),
                                    row(
                                      'Quantity',
                                      ' ${item['quantity']}',
                                      AppColors.grey,
                                      AppColors.yellow,
                                    ),
                                    Divider(),
                                  ],
                                ),
                              );
                            }).toList(),
                      ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: row(
                        'Total',
                        _controller.userOrder[index]['total'].toString(),
                        AppColors.grey,
                        AppColors.green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textButton(() {}, 'Cancel', AppColors.grey, 15),
                          Obx(() {
                            final isLoading =
                                _controller
                                    .loadingStates[userOrders[index]['orderId']] ??
                                false;

                            return GestureDetector(
                              onTap:
                                  isLoading
                                      ? null
                                      : () {
                                        _controller.confrimOrder(
                                          userId,
                                          userOrders[index]['orderId'],
                                          'confirm',
                                        );
                                        _controller.onlyConfirmOrder();
                                      },
                              child: Container(
                                width: 60,
                                height: 30,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      _controller.userOrder[index]['status'] !=
                                              'confirm'
                                          ? AppColors.yellow
                                          : AppColors.green,
                                ),
                                child:
                                    isLoading
                                        ? Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                        : Text(
                                          _controller.userOrder[index]['status'] !=
                                                  'confirm'
                                              ? 'Pending'
                                              : 'Confirm',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

Widget row(String label, String value, Color color, Color color1) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      Text(value, style: TextStyle(color: color1, fontWeight: FontWeight.w500)),
    ],
  );
}
