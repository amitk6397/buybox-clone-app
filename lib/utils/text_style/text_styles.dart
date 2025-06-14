import 'package:buybox_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

TextStyle startPage() {
  return TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.green,
  );
}

TextStyle nextButton() {
  return TextStyle(
    letterSpacing: 1,
    fontSize: 16,
    color: AppColors.white,
    fontWeight: FontWeight.w500,
  );
}

// home screen text Style

TextStyle nameText() {
  return TextStyle(
    fontSize: 25,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );
}

TextStyle categories() {
  return TextStyle(
    fontSize: 18,
    color: Colors.grey.shade700,
    fontWeight: FontWeight.bold,
  );
}

TextStyle categoriesText() {
  return TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
}

TextStyle categoriesItems() {
  return TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );
}

//appBar text style

TextStyle appBarText(Color color) {
  return TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.bold);
}

//Search screen Text

TextStyle searchScreenText() {
  return TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
}

// order screen

TextStyle deliveryText() {
  return TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
}
