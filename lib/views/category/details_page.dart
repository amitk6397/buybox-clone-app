import 'package:buybox_app/controllers/search_items_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';

import 'package:buybox_app/utils/components/bottom_sheet_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final SearchItemsController _controller = Get.put(SearchItemsController());
  final arg = Get.parameters;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: AppColors.green),
            child: Column(
              children: [
                SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: AppColors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        size: 30,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: mediaQuery.width * 0.9,
                    height: mediaQuery.width * 0.9,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.green,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 15,
                          spreadRadius: 2,
                          blurStyle: BlurStyle.normal,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 280,
            left: 0,
            bottom: 0,
            right: 0,
            child: SingleChildScrollView(
              //  physics: BouncingScrollPhysics(),
              child: Container(
                width: mediaQuery.width,

                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60),
                        container(
                          '${arg['index']}',
                          '${arg['title']}',
                          '${arg['unit_count']}',
                          '${arg['Price']}',
                          '${arg['originalPrice']}',
                        ),

                        SizedBox(height: 5),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Similar Products',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'View all >>',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.green,
                                ),
                              ),
                            ),
                          ],
                        ),

                        //Similar Product
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              _controller.product.length,
                              (index) {
                                return Obx(() {
                                  return GestureDetector(
                                    onTap: () {
                                      var product = _controller.product[index];
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return bottomSheet(
                                            index.toString(),
                                            product.productPhoto.toString(),
                                            product.productTitle.toString(),
                                            product.unitCount.toString(),
                                            product.productPrice.toString(),
                                            product.productOriginalPrice
                                                .toString(),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            _controller
                                                .product[index]
                                                .productPhoto
                                                .toString(),
                                            height: 100,
                                          ),
                                          Text(
                                            _controller
                                                .product[index]
                                                .productTitle!
                                                .replaceAll('Fresh', '')
                                                .split(',')[0]
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.grey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _controller
                                                    .product[index]
                                                    .productPrice
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.grey,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),

                                              Row(
                                                children: [
                                                  Text(
                                                    '(234)',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors.grey,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.star_rounded,
                                                    size: 20,
                                                    color: AppColors.yellow,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: -280,

            child: Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  "${arg['image']}",
                  width: 220,
                  height: 230,
                  fit: BoxFit.contain,

                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
