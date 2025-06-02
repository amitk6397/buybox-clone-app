import 'package:buybox_app/controllers/add_remove_cart_controller.dart';
import 'package:buybox_app/controllers/home_page_controller.dart';
import 'package:buybox_app/controllers/json_data_controller/fruits_json_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/search_items_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/category_button.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:buybox_app/views/category/all_category_items.dart';
import 'package:buybox_app/views/category/details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final FruitsJsonController _controller4 = Get.put(FruitsJsonController());

Widget card(
  HomePageController _controller,
  NavigationbarController? _controller3,
  int index,
) {
  return GestureDetector(
    onTap: () {
      final navKey = _controller3!.navigatorKeys[_controller3.index.value];
      navKey.currentState!.push(
        MaterialPageRoute(
          builder:
              (_) => AllCategoryItems(
                title: _controller.categoryImage[index]['name'],
              ),
        ),
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
  AddRemoveCartController _controller1,
  NavigationbarController _controller2,
  MediaQueryData mediaQuery,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
    child: Obx(() {
      return GridView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              mediaQuery.orientation == Orientation.portrait ? 2 : 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          childAspectRatio:
              mediaQuery.orientation == Orientation.portrait ? 0.8 : 0.9,
        ),
        itemCount: _controller.product.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  _controller4.getData();
                  var product = _controller.product[index];

                  final navKek =
                      _controller2
                          .navigatorKeys[_controller2.index.value]
                          .currentState;
                  navKek!.push(
                    MaterialPageRoute(
                      builder:
                          (_) => DetailsPage(
                            index: index,
                            id: product.asin.toString(),
                            image: product.productPhoto.toString(),
                            title: product.productTitle.toString(),
                            price: product.productPrice.toString(),
                          ),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  color: AppColors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        _controller.product[index].productPhoto.toString(),
                        height:
                            mediaQuery.orientation == Orientation.portrait
                                ? 90
                                : 70,
                        fit: BoxFit.cover,

                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            child: Center(child: Icon(Icons.error)),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 2,
                        ),
                        child: Text(
                          _controller.product[index].productTitle!,

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
                          vertical: 2,
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
                                  '(${_controller.product[index].productNumRatings})'
                                      .toString(),
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
                      Obx(() {
                        return _controller1.getCount(
                                  _controller.product[index].asin.toString(),
                                ) >
                                0
                            ? addRemove(
                              () {
                                _controller1.addItem(
                                  _controller.product[index].asin.toString(),
                                );
                              },
                              () {
                                _controller1.removeItem(
                                  _controller.product[index].asin.toString(),
                                );
                              },
                              _controller1.getCount(
                                _controller.product[index].asin.toString(),
                              ),
                            )
                            : addToCart(mediaQuery, () {
                              _controller1.addCartItems(
                                _controller.product[index].asin.toString(),
                                _controller.product[index].productTitle
                                    .toString(),
                                _controller.product[index].productPrice
                                    .toString(),
                                _controller.product[index].productPhoto
                                    .toString(),
                              );
                              _controller1.addItem(
                                _controller.product[index].asin.toString(),
                              );
                            });
                      }),
                    ],
                  ),
                ),
              ),
              Obx(() {
                return Positioned(
                  child: appBackButton(
                    _controller1.isFav(
                          _controller.product[index].asin.toString(),
                        )
                        ? AppColors.errorMessageColor
                        : AppColors.grey,
                    _controller1.isFav(
                          _controller.product[index].asin.toString(),
                        )
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    () {
                      _controller1.favItemToggle(
                        _controller.product[index].asin.toString(),
                        _controller.product[index].productTitle.toString(),
                        _controller.product[index].productPrice.toString(),
                        _controller.product[index].productPhoto.toString(),
                      );
                    },
                  ),
                );
              }),
            ],
          );
        },
      );
    }),
  );
}
