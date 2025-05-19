import 'package:buybox_app/controllers/firebase_auth_controller.dart';
import 'package:buybox_app/controllers/firebase_signUp_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/login_components.dart';
import 'package:buybox_app/utils/components/rich_text.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final FirebaseAuthController _controller = Get.find();
  final FirebaseSignupController _controller2 = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passfocusNode = FocusNode();
  FocusNode _userNameFocusNode = FocusNode();

  @override
  void dispose() {
    _userNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passfocusNode.dispose();
    emailController.dispose();
    passController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Image.asset(
                        'assets/images/login_logo.png',
                        width: 120,
                        height: 100,
                      ),

                      Text("Let's get you Signed up", style: startPage()),

                      Text(
                        'Sign up now to shop groceries online',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey,
                        ),
                      ),
                      SizedBox(height: 20),
                      textFeild(
                        userNameController,
                        'UserName',
                        _userNameFocusNode,
                        (_) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter Username';
                          } else if (value.length < 4) {
                            return 'UserName must be 4 or above';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      textFeild(
                        emailController,
                        'Email/Phone number',
                        _emailFocusNode,
                        (_) {
                          FocusScope.of(context).requestFocus(_passfocusNode);
                        },
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
                      passwordTextFeild(
                        passController,
                        'Password',
                        _passfocusNode,
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          bool upper = value.contains(RegExp(r'[A-Z]'));
                          bool lower = value.contains(RegExp(r'[a-z]'));
                          bool number = value.contains(RegExp(r'[0-9]'));
                          bool char = value.contains(RegExp(r'[@#$%^&*()]'));
                          if (value.length < 8) {
                            return 'password must be 8 digit';
                          } else if (!upper || !lower || !number || !char) {
                            return 'please enter valid password';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      button('Register', () {
                        _controller2.signUp(
                          userNameController.text.trim(),
                          emailController.text.trim(),
                          passController.text.trim(),
                        );
                      }, _controller2.isLoading),
                      SizedBox(height: 20),
                      Text(
                        'Or Register with',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      SizedBox(height: 20),
                      button3(
                        'Connect With Google',
                        'assets/images/Google.png',
                        () {
                          _controller.googleLogin();
                        },
                      ),
                      SizedBox(height: 20),
                      button2('Connect With Apple', Icons.apple, () {}),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("you have already account? "),
                          GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Get.offAndToNamed(AppRoutes.login);
                            },
                            child: Text(
                              'login',
                              style: TextStyle(
                                color: AppColors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
