import 'package:buybox_app/controllers/address_order_save_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/order_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/address_screen_components.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/components/image_slider.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final OrderController _controller = Get.find();
  final NavigationbarController _controller2 = Get.find();
  final AddressOrderSaveController _controller3 = Get.put(
    AddressOrderSaveController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    leading: appBackButton(Colors.black, Icons.arrow_back, () {
                      _controller2
                          .navigatorKeys[_controller2.index.value]
                          .currentState
                          ?.maybePop();
                    }),
                    title: Text('Checkout', style: appBarText(Colors.black)),
                    trailing: appBackButton(
                      Colors.black,
                      Icons.more_vert,
                      () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        circleAvatar(
                          AppColors.green,
                          Icons.check,
                          AppColors.white,
                        ),
                        checkLine(AppColors.green),
                        circleAvatar(
                          AppColors.green,
                          Icons.check,
                          AppColors.white,
                        ),
                        checkLine(AppColors.green),
                        circleContainer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery', style: deliveryText()),
                        Text('Address', style: deliveryText()),
                        Text('Payment', style: deliveryText()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 10,
              ),
              child: Obx(() {
                return Row(
                  spacing: 10,
                  children: [
                    paymentMethod(
                      'Cash On Delivery',
                      Icons.currency_rupee,
                      0,
                      _controller,
                    ),
                    paymentMethod(
                      'Credit/Debit Card',
                      Icons.credit_card,
                      1,
                      _controller,
                    ),
                    paymentMethod(
                      'PayPal Method',
                      Icons.paypal_outlined,
                      2,
                      _controller,
                    ),
                  ],
                );
              }),
            ),
            SizedBox(height: 20),
            Obx(() {
              return _controller.widgetChange[_controller.index.value];
            }),
            SizedBox(height: 20),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    _controller3.addOrderInFirebase();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.green,
                    ),
                    child: Center(
                      child: Text(
                        _controller.index.value == 0
                            ? 'CONFIRM ORDER'
                            : 'MAKE PAYMENT',
                        style: nextButton(),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

Widget paymentMethod(
  String label,
  IconData icon,
  int index,
  OrderController _controler,
) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        _controler.addIndex(index);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(
            width: _controler.index.value == index ? 2 : 0,
            color:
                _controler.index.value == index
                    ? AppColors.green
                    : AppColors.white,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 35,
              color:
                  _controler.index.value == index
                      ? AppColors.green
                      : Colors.grey.shade500,
            ),
            SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget firstWidget() {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.yellow,
        ),
        children: [
          TextSpan(text: 'Cash '),
          TextSpan(text: 'On ', style: startPage()),
          TextSpan(text: "Delivery"),
        ],
      ),
    ),
  );
}

Widget secondWidget() {
  final TextEditingController holderNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  final FocusNode holderNameFocus = FocusNode();
  final FocusNode cardNumberFocus = FocusNode();
  final FocusNode timeFocus = FocusNode();
  final FocusNode cvvFocus = FocusNode();
  return Column(
    children: [
      ImageSlider(),
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Card Holder Name', style: deliveryText()),
            addressTextFeild(
              holderNameController,
              'enter your Name',
              holderNameFocus,
              (_) {},
              (value) {},
            ),
            Text('Card Number', style: deliveryText()),
            addressTextFeild(
              cardNumberController,
              'enter your card number',
              cardNumberFocus,
              (_) {},
              (value) {},
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Month/Year', style: deliveryText()),
                      addressTextFeild(
                        timeController,
                        'Enter here',
                        timeFocus,
                        (_) {},
                        (value) {},
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CVV', style: deliveryText()),
                      addressTextFeild(
                        cvvController,
                        'Enter here',
                        cvvFocus,
                        (_) {},
                        (value) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: AppColors.green,
                  value: true,
                  onChanged: (ValueKey) {},
                ),
                Text('Save this card'),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget threeWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      children: [
        listTile('assets/payment/google1.png', 'Google Pay'),
        Divider(),
        SizedBox(height: 15),
        listTile('assets/payment/phonePe1.png', 'PhonePe'),
        Divider(),
        SizedBox(height: 15),
        listTile('assets/payment/paytm1.webp', 'Paytm'),
        Divider(),
      ],
    ),
  );
}

Widget listTile(String image, String label) {
  return ListTile(
    leading: Image.asset(image, width: 80, height: 80, fit: BoxFit.contain),
    title: Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
    trailing: Icon(Icons.arrow_right),
  );
}
