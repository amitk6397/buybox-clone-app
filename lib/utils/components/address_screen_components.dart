import 'package:buybox_app/controllers/order_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget checkLine(Color color) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        border: Border.all(color: color, width: 2),
      ),
    ),
  );
}

Widget circleContainer() {
  return Container(
    width: 33,
    height: 33,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(width: 4, color: AppColors.green),
    ),
    child: Center(
      child: Container(
        padding: EdgeInsets.all(5),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.green,
        ),
      ),
    ),
  );
}

Widget circleAvatar(Color color, IconData icon, Color iconColor) {
  return CircleAvatar(
    radius: 16,
    backgroundColor: color,
    child: Icon(icon, color: iconColor),
  );
}

Widget addressTextFeild(
  TextEditingController controller,
  String lable,
  FocusNode _focusNode,
  void Function(String)? onSubmitted,
  String? Function(String?)? validator,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: TextFormField(
      controller: controller,
      onFieldSubmitted: onSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.newline,
      focusNode: _focusNode,

      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade300,
        filled: true,
        hintText: lable,

        hintStyle: TextStyle(fontSize: 15, color: AppColors.grey),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 1, color: AppColors.green),
        ),
        isDense: true,
        errorStyle: TextStyle(height: 1),
      ),
      validator: validator,
    ),
  );
}
