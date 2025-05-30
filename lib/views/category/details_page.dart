import 'package:buybox_app/controllers/add_remove_cart_controller.dart';
import 'package:buybox_app/controllers/json_data_controller/fruits_json_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/search_items_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';

import 'package:buybox_app/utils/components/bottom_sheet_bar.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget {
  final int index;
  final String id;
  final String image;
  final String title;
  final String price;

  DetailsPage({
    required this.index,
    required this.id,
    required this.image,
    required this.title,
    required this.price,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final SearchItemsController _controller = Get.put(SearchItemsController());

  final NavigationbarController _controller1 = Get.find();
  final AddRemoveCartController _controller2 = Get.put(
    AddRemoveCartController(),
  );

  final FruitsJsonController _controller3 = Get.put(FruitsJsonController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final mediaQuery1 = MediaQuery.of(context);
    return Scaffold(
      body:
          mediaQuery1.orientation == Orientation.portrait
              ? Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(color: AppColors.green),
                    child: Column(
                      children: [
                        SizedBox(height: 48),
                        arrowAndSearchIcon(_controller1, _controller3),
                        ciricleWidget(mediaQuery),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 285,
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: SingleChildScrollView(
                      //  physics: BouncingScrollPhysics(),
                      child: Container(
                        width: mediaQuery.width,
                        height: mediaQuery.height * 0.6,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 50),
                              container(
                                widget.index,
                                widget.id,
                                widget.title,

                                widget.price,

                                widget.image,
                                _controller2,
                                _controller3,
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              similarProduct(
                                widget.index,
                                context,
                                _controller,
                                _controller2,
                                _controller3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: -210,

                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          widget.image,
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,

                          errorBuilder: (context, error, stackTrace) {
                            return Center(child: Icon(Icons.error));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(color: AppColors.green),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ciricleWidget(mediaQuery),
                        ),
                        Positioned.fill(
                          top: 30,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: arrowAndSearchIcon(
                              _controller1,
                              _controller3,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                widget.image,
                                width: 180,
                                height: 180,
                                fit: BoxFit.cover,

                                errorBuilder: (context, error, stackTrace) {
                                  return Center(child: Icon(Icons.error));
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: container(
                              widget.index,
                              widget.id,
                              widget.title,

                              widget.price,

                              widget.image,
                              _controller2,
                              _controller3,
                            ),
                          ),
                          similarProduct(
                            widget.index,
                            context,
                            _controller,
                            _controller2,
                            _controller3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}

Widget arrowAndSearchIcon(
  NavigationbarController _controller1,
  FruitsJsonController _controller,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      appBackButton(AppColors.white, Icons.arrow_back, () {
        _controller.itemChange(false);
        _controller1.navigatorKeys[_controller1.index.value].currentState
            ?.maybePop();
      }),
      appBackButton(AppColors.white, Icons.search, () {
        Get.toNamed(AppRoutes.search);
      }),
    ],
  );
}

Widget ciricleWidget(Size size) {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      width: size.width * 0.9,
      height: size.width * 0.9,
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
  );
}

Widget similarProduct(
  int index,
  BuildContext context,
  SearchItemsController _controller,
  AddRemoveCartController _controller2,
  FruitsJsonController _controller3,
) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(_controller.product.length, (index) {
        return Obx(() {
          return GestureDetector(
            onTap: () {
              var product = _controller.product[index];
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return bottomSheet(
                    index,
                    product.asin.toString(),

                    product.productTitle.toString(),

                    product.productPrice.toString(),

                    product.productPhoto.toString(),
                    _controller2,
                    _controller3,
                  );
                },
              );
            },
            child: Container(
              width: 120,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5),
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    _controller.product[index].productPhoto.toString(),
                    height: 70,
                  ),
                  Text(
                    _controller.product[index].productTitle!,

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _controller.product[index].productPrice.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Row(
                        children: [
                          Text(
                            '(${_controller.product[index].productNumRatings.toString()})',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.grey,
                            ),
                          ),
                          Icon(
                            Icons.star_rounded,
                            size: 18,
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
      }),
    ),
  );
}
