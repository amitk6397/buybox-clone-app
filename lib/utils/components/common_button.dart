import 'package:buybox_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

Widget appBackButton(Color color, IconData icon, VoidCallback onTap) {
  return IconButton(onPressed: onTap, icon: Icon(icon, color: color, size: 28));
}

//TextButton

Widget textButton(VoidCallback onTap, String lable, Color color, num size) {
  return TextButton(
    onPressed: onTap,
    child: Text(
      lable,
      style: TextStyle(color: color, fontSize: size.toDouble()),
    ),
  );
}
