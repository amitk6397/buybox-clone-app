import 'package:buybox_app/controllers/search_items_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0),
        child: Obx(() {
          return _controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: _controller.product.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    color: AppColors.white,
                    child: Column(
                      children: [
                        Image.network(
                          _controller.product[index].productPhoto.toString(),
                          height: 100,
                        ),
                        Text(
                          _controller.product[index].productTitle!
                              .replaceAll('Fresh', '')
                              .split(',')[0]
                              .toString(),
                        ),
                        Row(
                          children: [
                            Text(
                              _controller.product[index].productPrice
                                  .toString(),
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              style: TextStyle(),
                            ),
                            Row(
                              children: [
                                Text('(234)'),
                                Icon(
                                  Icons.star,
                                  size: 30,
                                  color: AppColors.yellow,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
        }),
      ),
    );
  }
}
