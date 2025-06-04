import 'package:buybox_app/controllers/add_remove_cart_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/order_controller.dart';
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
      body:
          mediaQuery.orientation == Orientation.portrait
              ? Column(
                children: [
                  topWidget(mediaQuery.size),
                  checkOutWidget(
                    _controller,
                    _controller1,
                    _controller2,
                    mediaQuery.size,
                  ),
                  Expanded(child: cartItemWidget(_controller)),
                  totalPriceWidget(_controller),
                ],
              )
              : Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: AppColors.green,
                  ),

                  SizedBox(
                    height: mediaQuery.size.height * 0.7,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: totalPriceWidget(_controller),
                              ),
                              SizedBox(height: 50),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: checkOutWidget(
                                  _controller,
                                  _controller1,
                                  _controller2,
                                  mediaQuery.size,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(child: cartItemWidget(_controller)),
                            ],
                          ),
                        ),
                      ],
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

Widget topWidget(Size size) {
  return Container(
    width: size.width,
    height: size.height * 0.35,
    decoration: BoxDecoration(color: AppColors.green),
    child: Column(
      children: [
        SizedBox(height: 50),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),

          title: Text('Shopping Cart', style: appBarText(AppColors.white)),
          trailing: appBackButton(AppColors.white, Icons.more_vert, () {}),
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
  );
}

Widget totalPriceWidget(AddRemoveCartController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
              '₹${controller.totalPrice.toStringAsFixed(2)}',
              Colors.grey.shade700,
            ),
            SizedBox(height: 15),
            row('Delivery', 'Free', AppColors.green),
            SizedBox(height: 15),
            row(
              'Total',
              '₹${controller.totalPrice.toStringAsFixed(2)}',
              Colors.black,
            ),
          ],
        );
      }),
    ),
  );
}

Widget cartItemWidget(AddRemoveCartController controller) {
  return Obx(() {
    return ListView(
      padding: EdgeInsets.only(top: 0),
      children: List.generate(controller.cartItems.length, (index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(controller.cartItems[index].image),
          ),
          title: Text(
            controller.cartItems[index].title,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(controller.cartItems[index].price),
          trailing: SizedBox(
            width: 120,
            child: addRemove(
              () {
                controller.addItem(controller.cartItems[index].id);
              },
              () {
                controller.removeItem(controller.cartItems[index].id);
              },
              controller.getCount(controller.cartItems[index].id),
            ),
          ),
        );
      }),
    );
  });
}

Widget checkOutWidget(
  AddRemoveCartController controller,
  OrderController controller1,
  NavigationbarController controller2,
  Size size,
) {
  return GestureDetector(
    onTap: () {
      controller1.getData();
      controller1.changeWidget(false);

      final navKey = controller2.navigatorKeys[controller2.index.value];
      navKey.currentState!.push(
        MaterialPageRoute(builder: (_) => AddressScreen()),
      );
    },
    child: Container(
      width: size.width,

      decoration: BoxDecoration(color: Colors.grey.shade100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
  );
}
