import 'package:buybox_app/controllers/add_remove_cart_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/order_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/category_button.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:buybox_app/views/order/address_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final AddRemoveCartController _controller = Get.find();
  final OrderController _controller1 = Get.put(OrderController());
  final NavigationbarController _controller2 = Get.find();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height * 0.35,
            decoration: BoxDecoration(color: AppColors.green),
            child: Column(
              children: [
                SizedBox(height: 50),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),

                  title: Text(
                    'Shopping Cart',
                    style: appBarText(AppColors.white),
                  ),
                  trailing: appBackButton(
                    AppColors.white,
                    Icons.more_vert,
                    () {},
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        'Off!!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '15%',
                        style: TextStyle(
                          letterSpacing: 10,
                          height: 0,
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _controller1.getData();
              _controller1.changeWidget(false);
              final navKey =
                  _controller2.navigatorKeys[_controller2.index.value];
              navKey.currentState!.push(
                MaterialPageRoute(builder: (_) => AddressScreen()),
              );
            },
            child: Container(
              width: mediaQuery.size.width,

              decoration: BoxDecoration(color: Colors.grey.shade100),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: Text(
                  textAlign: TextAlign.end,
                  'Checkout >>',
                  style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Obx(() {
            return Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                children: List.generate(_controller.cartItems.length, (index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        _controller.cartItems[index].image,
                      ),
                    ),
                    title: Text(
                      _controller.cartItems[index].title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(_controller.cartItems[index].price),
                    trailing: SizedBox(
                      width: 120,
                      child: addRemove(
                        () {
                          _controller.addItem(_controller.cartItems[index].id);
                        },
                        () {
                          _controller.removeItem(
                            _controller.cartItems[index].id,
                          );
                        },
                        _controller.getCount(_controller.cartItems[index].id),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Obx(() {
                return Column(
                  children: [
                    row(
                      'Subtotal',
                      '₹${_controller.totalPrice.toStringAsFixed(2)}',
                      Colors.grey.shade700,
                    ),
                    SizedBox(height: 15),
                    row('Delivery', 'Free', AppColors.green),
                    SizedBox(height: 15),
                    row(
                      'Total',
                      '₹${_controller.totalPrice.toStringAsFixed(2)}',
                      Colors.black,
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

Widget row(String label, String price, Color color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(color: AppColors.grey)),
      Text(price, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
    ],
  );
}
