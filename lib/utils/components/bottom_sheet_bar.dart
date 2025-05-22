import 'package:buybox_app/utils/app_colors.dart';

import 'package:buybox_app/utils/components/category_button.dart';
import 'package:flutter/material.dart';

Widget bottomSheet(
  String index,
  String image,
  String title,
  String unit_count,
  String price,
  String originalPrice,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 25),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Center(child: Image.network(image, width: 250, height: 200)),
          SizedBox(height: 10),
          container(index, title, unit_count, price, originalPrice),
          SizedBox(height: 40),
        ],
      ),
    ),
  );
}

Widget container(
  String index,
  String title,
  String unit_count,
  String price,
  String originalPrice,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 180,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightGreen, AppColors.yellow],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            '20% OFF DISCOUNT',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
        ),
      ),
      SizedBox(height: 8),
      Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      SizedBox(height: 2),
      Text("$unit_count piece", style: TextStyle(color: AppColors.grey)),
      SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                price,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Text(
                originalPrice,
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          Row(
            children: [
              icons(
                Icons.remove,
                () {},
                Colors.green.shade100,
                AppColors.green,
              ),
              SizedBox(width: 8),
              Text('0'),
              SizedBox(width: 8),
              icons(Icons.add, () {}, AppColors.green, AppColors.white),
            ],
          ),
        ],
      ),
      SizedBox(height: 20),
      // Delivery
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.star_rounded, color: AppColors.yellow),
              SizedBox(width: 6),
              Text(
                '4.6',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 3),
              Text(
                '(89 reviews)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Icon(Icons.delivery_dining),

          Text(
            'FREE DELIVERY',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ],
  );
}
