import 'package:buybox_app/controllers/firebase_auth_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/login_components.dart';
import 'package:buybox_app/utils/components/rich_text.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthController _controller = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passfocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passfocusNode.dispose();
    emailController.dispose();
    passController.dispose();
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
            FocusScope.of(context).unfocus();
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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

                      Text('Welcome Back!', style: startPage()),
                      //  SizedBox(height: 10),
                      Text(
                        'Access your account and shop grocerise online.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey,
                        ),
                      ),
                      SizedBox(height: 20),
                      textFeild(
                        emailController,
                        'Email/Phone number',
                        _emailFocusNode,
                        (_) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            FocusScope.of(context).requestFocus(_passfocusNode);
                          });
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.forgotPassword);
                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                color: AppColors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      button('Sign in', () {
                        _controller.login(
                          emailController.text.trim(),
                          passController.text.trim(),
                        );
                      }, _controller.isLoading),
                      SizedBox(height: 20),
                      Text(
                        'Or Sign in with',
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
                          Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Get.offAndToNamed(AppRoutes.signIn);
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: AppColors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
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
