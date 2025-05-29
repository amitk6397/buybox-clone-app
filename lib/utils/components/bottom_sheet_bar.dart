import 'package:buybox_app/controllers/add_remove_cart_controller.dart';
import 'package:buybox_app/controllers/json_data_controller/fruits_json_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';

import 'package:buybox_app/utils/components/category_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final FruitsJsonController _controller3 = Get.put(FruitsJsonController());

Widget bottomSheet(
  int index,
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
            index,
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
  int index,
  String id,
  String title,
  String unit_count,
  String price,
  String originalPrice,
  String image,
  AddRemoveCartController _controller1,
) {
  return Obx(() {
    var tit =
        _controller3.isChange.value
            ? _controller3.listData[index].title
            : title;
    var pric =
        _controller3.isChange.value
            ? _controller3.listData[index].price
            : price;
    var piec =
        _controller3.isChange.value
            ? _controller3.listData[index].piece
            : unit_count;
    var productId = _controller3.isChange.value ? '${id}A' : id;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
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
                  Text(
                    overflow: TextOverflow.ellipsis,
                    tit.trim(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller3.itemChange(false);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: _controller3.isChange.value ? 1 : 1,
                          color:
                              !_controller3.isChange.value
                                  ? AppColors.green
                                  : AppColors.white,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 13,
                              backgroundImage: NetworkImage(image),
                            ),
                            Text(
                              'Product 1',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _controller3.itemChange(true);
                      _controller3.getData();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: _controller3.isChange.value ? 1 : 1,
                          color:
                              !_controller3.isChange.value
                                  ? AppColors.white
                                  : AppColors.green,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundImage: NetworkImage(image),
                            ),
                            Text(
                              'Product 2',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(piec, style: TextStyle(color: AppColors.grey)),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  pric,
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
              return _controller3.isChange.value
                  ? addRemove(
                    () {
                      print(tit);
                      print(pric);
                      _controller1.addCartItems(productId, tit, pric, image);
                      _controller1.addItem(productId);
                    },
                    () {
                      print(tit);
                      print(pric);
                      _controller1.removeItem(productId);
                    },
                    _controller1.getCount(productId),
                  )
                  : addRemove(
                    () {
                      print(tit);
                      print(pric);
                      _controller1.addCartItems(productId, tit, pric, image);
                      _controller1.addItem(productId);
                    },
                    () {
                      print(tit);
                      print(pric);
                      _controller1.removeItem(productId);
                    },
                    _controller1.getCount(productId),
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
  });
}
