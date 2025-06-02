import 'dart:io';

import 'package:buybox_app/controllers/admin_controller/dashboard_controller.dart';
import 'package:buybox_app/controllers/admin_controller/food_order_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/views/admin/food_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminOrderPage extends StatefulWidget {
  const AdminOrderPage({super.key});

  @override
  State<AdminOrderPage> createState() => _AdminOrderPageState();
}

class _AdminOrderPageState extends State<AdminOrderPage> {
  final DashboardController _controller1 = Get.put(DashboardController());
  final FoodOrderController _controller = Get.put(FoodOrderController());

  @override
  void initState() {
    super.initState();
    _controller1.listOfUsers();
    _controller.userFoodOrder();
    _controller.onlyConfirmOrder();
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

            if (_controller.checkStatus == null ||
                _controller.checkStatus.isEmpty)
              return const SizedBox();

            return Obx(() {
              final hasConfirmed = _controller.checkStatus.any(
                (status) =>
                    status['userId'] == userId && status['status'] == 'confirm',
              );

              if (!hasConfirmed) return const SizedBox();

              final total =
                  _controller.userOrder.firstWhere(
                    (order) => order['userId'] == userId,
                    orElse: () => {'total': 0},
                  )['total'];

              return Card(
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
                        total.toString(),
                        AppColors.grey,
                        AppColors.green,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            });
          },
        );
      }),
    );
  }
}
