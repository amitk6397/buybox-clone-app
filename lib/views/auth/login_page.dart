import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/login_components.dart';
import 'package:buybox_app/utils/components/rich_text.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            image: NetworkImage(
              'https://previews.123rf.com/images/sanek13744/sanek137441801/sanek13744180100450/94602295-shopping-cart-seamless-pattern-background-business-concept-vector-illustration-cart-symbol-pattern.jpg',
            ),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/login_logo.png',
                  width: 120,
                  height: 100,
                ),

                Text('Welcome Back!', style: startPage()),
                SizedBox(height: 20),
                Text(
                  'Access your account and shop grocerise online.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 20),
                textFeild(emailController, 'Email/Phone number'),
                SizedBox(height: 20),
                textFeild(passController, 'Password'),
                SizedBox(height: 20),
                button('Sign in', () {}),
                SizedBox(height: 20),
                Text(
                  'Or Sign in with',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade400,
                  ),
                ),
                SizedBox(height: 20),
                button2('Connect With Google', Icons.add, () {}),
                SizedBox(height: 20),
                button2('Connect With Apple', Icons.apple, () {}),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text("Don't have an account?"),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.signIn);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
