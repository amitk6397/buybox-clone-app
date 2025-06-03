import 'dart:async';
import 'dart:io';

import 'package:buybox_app/controllers/get_firebasestore_data.dart';
import 'package:buybox_app/controllers/user_controller/image_picker_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/order_controller.dart';
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
  final NavigationbarController _controller3 = Get.find();
  final ProfileController _controller2 = Get.find();

  final user = FirebaseAuth.instance.currentUser!;

  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  TextEditingController textcontroller = TextEditingController();

  final ProfileController _controller = Get.find();

  final ImagePickerController _controller4 = Get.put(ImagePickerController());

  final pref = SharedPreferences.getInstance();

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
                  _controller,
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
          _controller3.navigatorKeys[_controller3.index.value].currentState
              ?.maybePop();
        }),
        title: Text('Personal Info', style: appBarText(AppColors.white)),
        backgroundColor: AppColors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.file(
                      File(_controller4.imagePath.value),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(child: Text('No Select Image'));
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),
                editUser('Name', _controller1.name.value, () {
                  updateDialog(
                    context,
                    'Change Your Name',
                    'name',
                    textcontroller,
                    _controller2,
                    _controller1,
                  );
                }, Icons.edit),

                editUser('Email', "${user.email}", () {}, null),

                editUser('D-O-B', _controller.date.value ?? '', () {
                  textcontroller.text = '';
                  updateDialog(
                    context,
                    'Change Your D-O-B/Add',
                    'DD/MM/YY',
                    textcontroller,
                    _controller2,
                    null,
                  );
                }, Icons.edit),

                editUser('Gender', _controller.gender.value ?? '', () {
                  textcontroller.text = '';
                  updateDialog(
                    context,
                    'Change Your Gender/Add',
                    'Gender',
                    textcontroller,
                    _controller2,
                    null,
                  );
                }, Icons.edit),

                editUser(
                  'Address',
                  _controller.address.value ?? '',
                  () {},
                  null,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

updateDialog(
  BuildContext context,
  String label,
  String hintText,
  TextEditingController controller,
  ProfileController controller1,
  GetFirebasestoreData? controller2,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              textfield(hintText, null, controller),
            ],
          ),
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
            () async {
              if (controller.text.trim().isEmpty) {
                Get.snackbar(
                  'UserName',
                  'Please enter your name',
                  backgroundColor: AppColors.errorMessageColor,
                );
              } else {
                await controller1.changeName(controller.text);
                controller2?.fetchData();

                Navigator.of(context).pop();
                Get.snackbar(
                  'Success',
                  'Update your name',
                  backgroundColor: AppColors.successMessageColor,
                );
              }
            },
            'Add',
            Colors.black,
            16,
          ),
        ],
      );
    },
  );
}
