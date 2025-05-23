import 'package:buybox_app/controllers/home_page_controller.dart';
import 'package:buybox_app/controllers/search_items_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/category_button.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget card(HomePageController _controller, int index) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(
        AppRoutes.allItems,
        parameters: {'title': _controller.categoryImage[index]['name']},
      );
    },
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      _controller.categoryImage[index]['name'],
                      style: categoriesText(),
                    ),
                    Text(
                      _controller.categoryImage[index]['items'],
                      style: categoriesItems(),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 13,
                          decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topRight: Radius.elliptical(40, 20),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 13,
                            decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.elliptical(40, 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          top: -5,
          child: Align(
            alignment: Alignment.topCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                _controller.categoryImage[index]['path'],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget itemsWidget(
  SearchItemsController _controller,
  MediaQueryData mediaQuery,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0),
    child: Obx(() {
      return _controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  mediaQuery.orientation == Orientation.portrait ? 2 : 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio:
                  mediaQuery.orientation == Orientation.portrait ? 0.7 : 0.9,
            ),
            itemCount: _controller.product.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.details,
                    parameters: {
                      'index': index.toString(),
                      'image':
                          _controller.product[index].productPhoto.toString(),
                      'title':
                          _controller.product[index].productTitle.toString(),
                      'Price':
                          _controller.product[index].productPrice!.toString(),
                      'originalPrice':
                          _controller.product[index].productOriginalPrice!
                              .toString(),

                      'unit_count':
                          _controller.product[index].unitCount.toString(),
                    },
                  );
                },
                child: Card(
                  elevation: 4,
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        _controller.product[index].productPhoto.toString(),
                        height: 100,
                        fit: BoxFit.cover,

                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            height: 100,
                            child: Center(child: Icon(Icons.error)),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 4,
                        ),
                        child: Text(
                          _controller.product[index].productTitle!
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _controller.product[index].productPrice
                                  .toString(),
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
                      ),
                      addToCart(),
                    ],
                  ),
                ),
              );
            },
          );
    }),
  );
}
