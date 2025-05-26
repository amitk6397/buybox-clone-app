import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/order_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/address_screen_components.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/components/login_components.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:buybox_app/views/order/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OrderController _controller = Get.find();
  final NavigationbarController _controller2 = Get.find();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            leading: appBackButton(
                              Colors.black,
                              Icons.arrow_back,
                              () {
                                _controller2
                                    .navigatorKeys[_controller2.index.value]
                                    .currentState
                                    ?.maybePop();
                              },
                            ),
                            title: Text(
                              'Checkout',
                              style: appBarText(Colors.black),
                            ),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25.0,
                              ),
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
                                  Obx(() {
                                    return SizedBox(
                                      height: 300,
                                      child: ListView(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: List.generate(
                                          _controller.getAddress.length,
                                          (index) {
                                            var getAddress =
                                                _controller.getAddress[index];

                                            return Stack(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    _controller.selectAddress(
                                                      index,
                                                    );
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                      bottom: 10,
                                                      top: 10,
                                                    ),
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            15,
                                                          ),
                                                      border: Border.all(
                                                        width:
                                                            _controller.selectIndex ==
                                                                    index
                                                                ? 1
                                                                : 1,
                                                        color:
                                                            _controller.selectIndex ==
                                                                    index
                                                                ? AppColors
                                                                    .green
                                                                : AppColors
                                                                    .white,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            10.0,
                                                          ),
                                                      child: Text(
                                                        '${getAddress['name']}, ${getAddress['phone']}, ${getAddress['email']}, ${getAddress['address']}, ${getAddress['city']}, ${getAddress['country']}, ${getAddress['code'] ?? ''}',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                _controller.selectIndex == index
                                                    ? Positioned(
                                                      right: 2,
                                                      top: 10,
                                                      child: Icon(
                                                        Icons.check_circle,
                                                        color: AppColors.green,
                                                      ),
                                                    )
                                                    : SizedBox(),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                            : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10,
                              ),
                              child: AddAddressUi(
                                formKey: _formKey,
                                controller: _controller,
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
                          if (_controller.isFlag.value) {
                            if (_formKey.currentState!.validate()) {
                              if (_controller.isSava.value) {
                                _controller.storeData(
                                  nameController.text,
                                  emailController.text,
                                  phoneController.text,
                                  addressController.text,
                                  zipCodeController.text,
                                  cityController.text,
                                  countryController.text,
                                );
                                nameController.clear();
                                emailController.clear();
                                phoneController.clear();
                                addressController.clear();
                                zipCodeController.clear();
                                cityController.clear();
                                countryController.clear();

                                _controller.getData();
                                _controller.changeWidget(false);

                                if (_controller.getAddress.isNotEmpty) {
                                  final navKey =
                                      _controller2.navigatorKeys[_controller2
                                          .index
                                          .value];
                                  navKey.currentState!.push(
                                    MaterialPageRoute(
                                      builder: (_) => AddressScreen(),
                                    ),
                                  );
                                }
                              } else {
                                Get.snackbar(
                                  'Save Address',
                                  'Please fill the checkbox',
                                  colorText: AppColors.white,
                                  backgroundColor: AppColors.errorMessageColor,
                                );
                              }
                            }
                          } else {
                            if (_controller.getAddress.isEmpty) {
                              Get.snackbar(
                                'Address',
                                'Please add your address',
                                backgroundColor: AppColors.errorMessageColor,
                              );
                            } else {
                              final navKey =
                                  _controller2.navigatorKeys[_controller2
                                      .index
                                      .value];
                              navKey.currentState!.push(
                                MaterialPageRoute(
                                  builder: (_) => PaymentScreen(),
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.green,
                          ),
                          child: Center(
                            child: Text('NEXT', style: nextButton()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddAddressUi extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final OrderController controller;

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
    required this.formKey,
    required this.controller,
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
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Full Name', style: deliveryText()),
            addressTextFeild(
              nameController,
              'enter your name',
              nameFocus,
              (_) {
                FocusScope.of(context).requestFocus(emailFocus);
              },
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                } else {
                  return null;
                }
              },
            ),
            Text('Email Address', style: deliveryText()),
            addressTextFeild(
              emailController,
              'enter your email',
              emailFocus,
              (_) {
                FocusScope.of(context).requestFocus(phoneFocus);
              },
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'Please enter your valid email';
                } else {
                  return null;
                }
              },
            ),
            Text('Phone', style: deliveryText()),
            addressTextFeild(
              phoneController,
              'enter your phone number',
              phoneFocus,
              (_) {
                FocusScope.of(context).requestFocus(addressFocus);
              },
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                  return 'Please enter valid phone number';
                } else {
                  return null;
                }
              },
            ),
            Text('Address', style: deliveryText()),
            addressTextFeild(
              addressController,
              'enter your home address',
              addressFocus,
              (_) {
                FocusScope.of(context).requestFocus(zipCodeFocus);
              },
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                } else {
                  return null;
                }
              },
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
                        (_) {
                          FocusScope.of(context).requestFocus(cityFocus);
                        },
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your zipcode';
                          } else {
                            return null;
                          }
                        },
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
                        (_) {
                          FocusScope.of(context).requestFocus(countryFocus);
                        },
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your city';
                          } else {
                            return null;
                          }
                        },
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
              (_) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your country';
                } else {
                  return null;
                }
              },
            ),
            Obx(() {
              return Row(
                children: [
                  Checkbox(
                    activeColor: AppColors.green,
                    value: controller.isSava.value,
                    onChanged: (ValueKey) {
                      controller.saveData();
                    },
                  ),
                  Text('Save shipping address'),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
