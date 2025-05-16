import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';

Widget textFeild(TextEditingController controller, String lable) {
  return Container(
    height: 60,
    padding: EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(width: 1, color: AppColors.green),
    ),
    child: TextField(
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

Widget button(String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.green,
      ),
      child: Center(child: Text(label, style: nextButton())),
    ),
  );
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
          Icon(icon, size: 40),
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
