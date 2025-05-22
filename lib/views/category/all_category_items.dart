import 'package:buybox_app/controllers/search_items_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/category_button.dart';
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
        leading: IconButton(
          onPressed: () {
            _controller.product.clear();
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: AppColors.white, size: 28),
        ),
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
