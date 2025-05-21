import 'dart:async';

import 'package:buybox_app/controllers/get_firebasestore_data.dart';
import 'package:buybox_app/controllers/home_page_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/search_items_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/image_slider.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomePageController _controller = Get.find();
  final SearchItemsController _controller1 = Get.find();
  final GetFirebasestoreData _controller2 = Get.find();
  final NavigationbarController _controller3 = Get.find();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller2.fetchData();
    Timer(Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      bool flag = prefs.getBool('location') ?? false;
      if (prefs.getBool('location') == null || flag == true) {
        Get.toNamed(AppRoutes.location);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                "Good Morning",
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Text(_controller2.name.value, style: nameText()),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.waving_hand_rounded, color: AppColors.yellow),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: CircleAvatar(
                      backgroundColor: AppColors.yellow,
                      child: Icon(Icons.notifications, color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: AppColors.grey),
                  ),
                  child: AbsorbPointer(
                    child: TextField(
                      focusNode: _focusNode,

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: 'Search for over 5000+ product',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ImageSlider(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Categories', style: categories()),
                  IconButton(
                    onPressed: () {
                      _controller3.changeScreen(1);
                    },
                    icon: Icon(Icons.arrow_forward_ios, size: 25),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Row(
                  spacing: 10,
                  children: List.generate(_controller.categoryImage.length, (
                    index,
                  ) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.allItems,
                                  parameters: {
                                    'title':
                                        _controller
                                            .categoryImage[index]['name'],
                                  },
                                );
                              },
                              child: Container(
                                width: 105,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          _controller
                                              .categoryImage[index]['name'],
                                          style: categoriesText(),
                                        ),
                                        Text(
                                          _controller
                                              .categoryImage[index]['items'],
                                          style: categoriesItems(),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 13,
                                              decoration: BoxDecoration(
                                                color: AppColors.yellow,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(
                                                    15,
                                                  ),
                                                  topRight: Radius.elliptical(
                                                    40,
                                                    20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 75,
                                              height: 13,
                                              decoration: BoxDecoration(
                                                color: AppColors.yellow,
                                                borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(
                                                    15,
                                                  ),
                                                  topLeft: Radius.elliptical(
                                                    40,
                                                    20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: -5,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  _controller.categoryImage[index]['path'],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 0),
              child: Text('Popular Deals', style: categories()),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 0,
              ),
              child: Obx(() {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: _controller1.product.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      color: AppColors.green,
                      child: Column(
                        children: [
                          Image.network(
                            _controller1.product[index].productPhoto.toString(),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
