import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

RichText richText() {
  return RichText(
    text: TextSpan(
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      children: [
        TextSpan(text: 'Welcome to '),
        TextSpan(text: 'BuyBox\n', style: startPage()),
        TextSpan(text: "We're excited to have you onboard."),
      ],
    ),
  );
}
//2

RichText richText2() {
  return RichText(
    text: TextSpan(
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      children: [
        TextSpan(text: 'Need inspiration?\n', style: startPage()),
        TextSpan(text: 'Check out our recommend item and deals'),
      ],
    ),
  );
}

//3

RichText richText3() {
  return RichText(
    text: TextSpan(
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      children: [
        TextSpan(
          text: "We'll deliver your groceries straight to your doorstep.\n",
        ),
        TextSpan(text: 'Enjoy!', style: startPage()),
      ],
    ),
  );
}

// for login page

RichText richText4() {
  return RichText(
    text: TextSpan(
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      children: [
        TextSpan(text: 'Buy'),
        TextSpan(
          text: 'Box',
          style: TextStyle(
            color: AppColors.yellow,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}
