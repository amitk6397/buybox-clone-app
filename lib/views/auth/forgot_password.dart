import 'package:buybox_app/controllers/forgot_password_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/login_components.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  final ForgotPasswordController _controller = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/cooking_background.webp'),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Image.asset(
                            'assets/images/login_logo.png',
                            width: 120,
                            height: 100,
                          ),
                          SizedBox(height: 10),
                          Text('Forgot Password!', style: startPage()),

                          SizedBox(height: 20),
                          textFeild(
                            emailController,
                            'Email/Phone number',
                            _emailFocusNode,
                            (_) {},
                            (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email or phone number';
                              } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  ).hasMatch(value) &&
                                  !RegExp(r'^[0-9]{10}$').hasMatch(value) &&
                                  value.isNotEmpty) {
                                return 'Please enter a valid email or phone number.';
                              } else {
                                return null;
                              }
                            },
                          ),

                          SizedBox(height: 20),
                          button('Reset Password', () {
                            _controller.forgotPassword(emailController.text);
                          }, _controller.isLoading),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 10,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.green,
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
