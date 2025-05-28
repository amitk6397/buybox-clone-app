import 'package:buybox_app/controllers/add_remove_cart_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';

import 'package:buybox_app/utils/components/category_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bottomSheet(
  String id,

  String title,
  String unit_count,
  String price,
  String originalPrice,
  String image,
  AddRemoveCartController _controller1,
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
          container(
            id,
            title,
            unit_count,
            price,
            originalPrice,
            image,
            _controller1,
          ),
          SizedBox(height: 40),
        ],
      ),
    ),
  );
}

Widget container(
  String id,
  String title,
  String unit_count,
  String price,
  String originalPrice,
  String image,
  AddRemoveCartController _controller1,
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
      SizedBox(height: 5),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  fontSize: 20,
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
          Obx(() {
            return addRemove(
              () {
                _controller1.addCartItems(id, title, price, image);
                _controller1.addItem(id);
              },
              () {
                _controller1.removeItem(id);
              },
              _controller1.getCount(id),
            );
          }),
        ],
      ),
      SizedBox(height: 10),
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
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 3),
              Text(
                '(89 reviews)',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.delivery_dining, size: 18),
              SizedBox(width: 5),
              Text(
                'FREE DELIVERY',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
