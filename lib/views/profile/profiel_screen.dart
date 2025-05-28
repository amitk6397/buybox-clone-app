import 'package:buybox_app/controllers/get_firebasestore_data.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/profile_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/components/profile_components.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:buybox_app/views/profile/personalInfo_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfielScreen extends StatelessWidget {
  final GetFirebasestoreData _controller = Get.put(GetFirebasestoreData());
  final ProfileController _controller1 = Get.put(ProfileController());
  final NavigationbarController _controller2 = Get.find();
  singOut() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();

    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),

                title: Text('Profile', style: appBarText(AppColors.green)),
                trailing: appBackButton(
                  AppColors.green,
                  Icons.more_vert,
                  () {},
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
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
                          Positioned(
                            child: appBackButton(
                              AppColors.yellow,
                              Icons.edit,
                              () {},
                            ),
                          ),
                        ],
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
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
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

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _controller2
                              .navigatorKeys[_controller2.index.value]
                              .currentState!
                              .push(
                                MaterialPageRoute(
                                  builder: (_) => PersonalInfoPage(),
                                ),
                              );
                        });
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
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
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
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
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
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
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
    );
  }
}
