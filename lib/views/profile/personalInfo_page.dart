import 'dart:async';

import 'package:buybox_app/controllers/get_firebasestore_data.dart';
import 'package:buybox_app/controllers/profile_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/components/profile_components.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoPage extends StatefulWidget {
  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final GetFirebasestoreData _controller1 = Get.put(GetFirebasestoreData());
  final user = FirebaseAuth.instance.currentUser!;

  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  final ProfileController _controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(Duration(seconds: 2), () async {
        final prefs = await SharedPreferences.getInstance();
        if (prefs.getString('date') == null ||
            prefs.getString('gender') == null) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: alertContainer(
                  genderController,
                  dobController,
                  context,
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
                      Get.back();
                    },
                    'Add',
                    Colors.black,
                    16,
                  ),
                ],
              );
            },
          );
        } else {}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: appBackButton(AppColors.white, Icons.arrow_back, () {
          Get.back();
        }),
        title: Text('Personal Info', style: appBarText()),
        backgroundColor: AppColors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Obx(() {
          return Column(
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.green,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Text('No Select Image'));
                  },
                ),
              ),
              SizedBox(height: 15),
              editUser('Name', _controller1.name.value, () {}),

              editUser('Email', "${user.email}", () {}),

              editUser('D-O-B', _controller.date.value, () {}),

              editUser('Gender', _controller.gender.value, () {}),

              editUser('Address', _controller.address.value ?? '', () {}),
            ],
          );
        }),
      ),
    );
  }
}
