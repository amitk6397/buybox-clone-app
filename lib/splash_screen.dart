import 'dart:async';

import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/views/start_page/start_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

    Timer(Duration(seconds: 5), () {
      Get.toNamed(AppRoutes.startApp);
    });
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
                  image: NetworkImage(
                    'https://previews.123rf.com/images/sanek13744/sanek137441801/sanek13744180100450/94602295-shopping-cart-seamless-pattern-background-business-concept-vector-illustration-cart-symbol-pattern.jpg',
                  ),
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
