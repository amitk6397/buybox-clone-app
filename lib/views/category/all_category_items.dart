import 'package:buybox_app/controllers/add_remove_cart_controller.dart';
import 'package:buybox_app/controllers/json_data_controller/fruits_json_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/search_items_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/category_button.dart';
import 'package:buybox_app/utils/components/category_components.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/components/image_slider.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategoryItems extends StatefulWidget {
  @override
  State<AllCategoryItems> createState() => _AllCategoryItemsState();
  final String title;
  AllCategoryItems({required this.title});
}

class _AllCategoryItemsState extends State<AllCategoryItems> {
  final SearchItemsController _controller = Get.put(SearchItemsController());
  final AddRemoveCartController _controller1 = Get.find();
  final NavigationbarController _controller2 = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.fetchData(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: appBackButton(AppColors.white, Icons.arrow_back, () {
          _controller2.navigatorKeys[_controller2.index.value].currentState
              ?.maybePop();
        }),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.search);
            },
            icon: Icon(Icons.search, size: 28, color: AppColors.white),
          ),
          SizedBox(width: 10),
        ],
        title: Obx(
          () => Text(
            "${widget.title}(${_controller.product.length})",
            style: appBarText(AppColors.white),
          ),
        ),
        backgroundColor: AppColors.green,
      ),
      body:
          mediaQuery.orientation == Orientation.portrait
              ? Obx(() {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      ImageSlider(),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Divider(),
                      ),
                      SizedBox(height: 5),
                      _controller.isLoading.value
                          ? CircularProgressIndicator()
                          : itemsWidget(
                            _controller,
                            _controller1,
                            _controller2,
                            mediaQuery,
                          ),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              })
              : Obx(() {
                return Row(
                  children: [
                    Expanded(flex: 1, child: ImageSlider()),
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child:
                            _controller.isLoading.value
                                ? CircularProgressIndicator()
                                : itemsWidget(
                                  _controller,
                                  _controller1,
                                  _controller2,
                                  mediaQuery,
                                ),
                      ),
                    ),
                  ],
                );
              }),
    );
  }
}
