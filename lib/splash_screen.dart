import 'dart:async';

import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/views/start_page/start_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
    sharedpre();
  }

  sharedpre() async {
    final pref = await SharedPreferences.getInstance();

    if (pref.getString('token') != null) {
      Timer(Duration(seconds: 5), () {
        Get.offAllNamed(AppRoutes.myHome);
      });
    } else {
      Timer(Duration(seconds: 5), () {
        Get.offAllNamed(AppRoutes.startApp);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 48),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.green,
                image: DecorationImage(
                  image: AssetImage('assets/images/cooking_background.webp'),
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ),
              ),

              child: Center(child: Image.asset('assets/images/logo.png')),
            ),
          ),
        ],
      ),
    );
  }
}
