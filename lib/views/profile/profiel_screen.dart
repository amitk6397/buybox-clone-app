import 'package:buybox_app/controllers/get_firebasestore_data.dart';
import 'package:buybox_app/controllers/profile_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/components/profile_components.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfielScreen extends StatelessWidget {
  final GetFirebasestoreData _controller = Get.put(GetFirebasestoreData());
  final ProfileController _controller1 = Get.put(ProfileController());
  singOut() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();

    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: appBarText(AppColors.white)),
        backgroundColor: AppColors.green,
      ),
      backgroundColor: AppColors.green,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/cooking_background.webp'),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Card(
                  color: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.yellow,
                            ),
                          ),
                        ),
                        SizedBox(width: 40),
                        Column(
                          children: [
                            Obx(
                              () => Text(
                                _controller.name.value,
                                style: startPage(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListtileWidget(
                        label: 'Personal Info',
                        icon: Icons.person,
                        color: Colors.deepOrange,
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          _controller1.setDate(
                            prefs.getString('date').toString(),
                          );
                          _controller1.setGender(
                            prefs.getString('gender').toString(),
                          );
                          _controller1.getAddress(
                            prefs.getString('address').toString(),
                          );
                          print(prefs.getString('address').toString());
                          Get.toNamed(AppRoutes.personalInfo);
                        },
                      ),
                      ListtileWidget(
                        label: 'Addresses',
                        icon: Icons.details_outlined,
                        color: Colors.blue,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListtileWidget(
                        label: 'Cart',
                        icon: Icons.shopping_cart,
                        color: Colors.lightBlue,
                        onTap: () {},
                      ),

                      ListtileWidget(
                        label: 'Notification',
                        icon: Icons.notifications,
                        color: Colors.orange,
                        onTap: () {},
                      ),
                      ListtileWidget(
                        label: 'Payment Method',
                        icon: Icons.payment,
                        color: Colors.lightBlue,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListtileWidget(
                        label: 'FAQs',
                        icon: Icons.question_mark,
                        color: Colors.deepOrange,
                        onTap: () {},
                      ),
                      ListtileWidget(
                        label: 'User Reviews',
                        icon: Icons.reviews,
                        color: Colors.lightBlue,
                        onTap: () {},
                      ),
                      ListtileWidget(
                        label: 'Settings',
                        icon: Icons.settings,
                        color: Colors.blueAccent,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListtileWidget(
                        label: 'Log Out',
                        icon: Icons.logout,
                        color: Colors.deepOrange,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Logout Confirmation",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                content: Text(
                                  "You are about to log out of your account. This will end your session, and you'll need to log in again to access your data. Do you want to continue?",
                                  style: TextStyle(fontSize: 16),
                                ),
                                actions: [
                                  textButton(
                                    () {
                                      Get.back();
                                    },
                                    'Cancel',
                                    Colors.black,
                                    16,
                                  ),
                                  textButton(
                                    () {
                                      singOut();
                                      Get.snackbar(
                                        "LogOut",
                                        'You have successfully logged out',
                                        backgroundColor:
                                            AppColors.successMessageColor,
                                      );
                                    },
                                    'Ok',
                                    Colors.black,
                                    16,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
