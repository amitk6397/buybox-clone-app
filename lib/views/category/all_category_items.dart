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
}

class _AllCategoryItemsState extends State<AllCategoryItems> {
  final arg = Get.parameters;

  final SearchItemsController _controller = Get.put(SearchItemsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.fetchData(arg['title'].toString());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: appBackButton(AppColors.white, Icons.arrow_back, () {
          Get.back();
        }),
        title: Text('${arg['title']}', style: appBarText()),
        backgroundColor: AppColors.green,
      ),
      body: SingleChildScrollView(
        child:
            mediaQuery.orientation == Orientation.portrait
                ? Column(
                  children: [
                    SizedBox(height: 25),
                    ImageSlider(),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Divider(),
                    ),
                    SizedBox(height: 10),
                    itemsWidget(_controller, mediaQuery),
                    SizedBox(height: 20),
                  ],
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageSlider(),
                    itemsWidget(_controller, mediaQuery),
                  ],
                ),
      ),
    );
  }
}
