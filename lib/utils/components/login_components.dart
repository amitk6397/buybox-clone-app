import 'package:buybox_app/controllers/firebase_auth_controller.dart';
import 'package:buybox_app/controllers/firebase_signUp_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget textFeild(
  TextEditingController controller,
  String lable,
  FocusNode _focusNode,
  void Function(String)? onSubmitted,
  String? Function(String?)? validator,
) {
  return Container(
    height: 60,
    padding: EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(width: 1, color: AppColors.green),
    ),
    child: TextFormField(
      controller: controller,
      onFieldSubmitted: onSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.newline,
      focusNode: _focusNode,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        label: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(lable),
        ),

        labelStyle: TextStyle(color: AppColors.grey),

        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        isDense: true,
        errorStyle: TextStyle(height: 1),
      ),
      validator: validator,
    ),
  );
}

Widget passwordTextFeild(
  TextEditingController controller,
  String lable,
  FocusNode _focusNode,
  String? Function(String?)? validator,
) {
  return Container(
    height: 60,
    padding: EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(width: 1, color: AppColors.green),
    ),
    child: TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      textInputAction: TextInputAction.done,

      style: TextStyle(fontSize: 20),
      obscureText: true,

      focusNode: _focusNode,
      decoration: InputDecoration(
        label: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(lable),
        ),
        // labelText: lable,
        labelStyle: TextStyle(color: AppColors.grey),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        isDense: true,
      ),
    ),
  );
}

Widget button(String label, VoidCallback onTap, RxBool isLoading) {
  return Obx(() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.green,
        ),
        child: Center(
          child:
              isLoading.value
                  ? CircularProgressIndicator(backgroundColor: AppColors.white)
                  : Text(label, style: nextButton()),
        ),
      ),
    );
  });
}

Widget button2(String label, IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(width: 1, color: AppColors.green),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 30),
          Icon(icon, size: 50),
          SizedBox(width: 30),
          Text(
            label,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}

Widget button3(String label, String image, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(width: 1, color: AppColors.green),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 35),
          Image.asset(image, width: 40, height: 40),
          SizedBox(width: 30),
          Text(
            label,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}
