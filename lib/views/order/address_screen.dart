import 'package:buybox_app/controllers/order_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/address_screen_components.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/components/login_components.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final OrderController _controller = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode zipCodeFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode countryFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    leading: appBackButton(
                      Colors.black,
                      Icons.arrow_back,
                      () {},
                    ),
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
                        circleContainer(),
                        checkLine(AppColors.grey),

                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey.shade400,
                        ),
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
            Flexible(
              child: Obx(() {
                return !_controller.isFlag.value
                    ? Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery Address',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(''),
                          GestureDetector(
                            onTap: () {
                              _controller.changeWidget(true);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    size: 30,
                                    color: AppColors.green,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Add New Address',
                                    style: deliveryText(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    : SingleChildScrollView(
                      padding: const EdgeInsets.all(20.0),
                      child: AddAddressUi(
                        nameController: nameController,
                        emailController: emailController,
                        phoneController: phoneController,
                        addressController: addressController,
                        zipCodeController: zipCodeController,
                        cityController: cityController,
                        countryController: countryController,
                        nameFocus: nameFocus,
                        emailFocus: emailFocus,
                        phoneFocus: phoneFocus,
                        addressFocus: addressFocus,
                        zipCodeFocus: zipCodeFocus,
                        cityFocus: cityFocus,
                        countryFocus: countryFocus,
                      ),
                    );
              }),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  _controller.storeData(
                    nameController.text,
                    emailController.text,
                    phoneController.text,
                    addressController.text,
                    zipCodeController.text,
                    cityController.text,
                    countryController.text,
                  );
                  nameController.text = '';
                  emailController.text = '';
                  phoneController.text = '';
                  addressController.text = '';
                  zipCodeController.text = '';
                  cityController.text = '';
                  countryController.text = '';
                  _controller.changeWidget(false);

                  Get.toNamed(AppRoutes.payment);
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.green,
                  ),
                  child: Center(child: Text('NEXT', style: nextButton())),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddAddressUi extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController zipCodeController;
  final TextEditingController cityController;
  final TextEditingController countryController;

  final FocusNode nameFocus;
  final FocusNode emailFocus;
  final FocusNode phoneFocus;
  final FocusNode addressFocus;
  final FocusNode zipCodeFocus;
  final FocusNode cityFocus;
  final FocusNode countryFocus;

  AddAddressUi({
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.zipCodeController,
    required this.cityController,
    required this.countryController,
    required this.nameFocus,
    required this.emailFocus,
    required this.phoneFocus,
    required this.addressFocus,
    required this.zipCodeFocus,
    required this.cityFocus,
    required this.countryFocus,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Full Name', style: deliveryText()),
          addressTextFeild(
            nameController,
            'enter your name',
            nameFocus,
            (_) {},
            (value) {},
          ),
          Text('Email Address', style: deliveryText()),
          addressTextFeild(
            emailController,
            'enter your email',
            emailFocus,
            (_) {},
            (value) {},
          ),
          Text('Phone', style: deliveryText()),
          addressTextFeild(
            phoneController,
            'enter your phone number',
            phoneFocus,
            (_) {},
            (value) {},
          ),
          Text('Address', style: deliveryText()),
          addressTextFeild(
            addressController,
            'enter your home address',
            addressFocus,
            (_) {},
            (value) {},
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Zip Code', style: deliveryText()),
                    addressTextFeild(
                      zipCodeController,
                      'Enter code',
                      zipCodeFocus,
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
                    Text('City', style: deliveryText()),
                    addressTextFeild(
                      cityController,
                      'Enter city',
                      cityFocus,
                      (_) {},
                      (value) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text('Country', style: deliveryText()),
          addressTextFeild(
            countryController,
            'Choose your country',
            countryFocus,
            (_) {},
            (value) {},
          ),
          Row(
            children: [
              Checkbox(
                activeColor: AppColors.green,
                value: true,
                onChanged: (ValueKey) {},
              ),
              Text('Save shipping address'),
            ],
          ),
        ],
      ),
    );
  }
}
