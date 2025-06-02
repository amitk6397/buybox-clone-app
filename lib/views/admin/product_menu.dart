import 'package:buybox_app/controllers/admin_controller/product_menu_controller.dart';
import 'package:buybox_app/services/db_helper.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductMenu extends StatefulWidget {
  String? tableName;

  ProductMenu({required this.tableName});

  @override
  State<ProductMenu> createState() => _ProductMenuState();
}

class _ProductMenuState extends State<ProductMenu> {
  final ProductMenuContoller _controller = Get.put(ProductMenuContoller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getStoreData(widget.tableName!);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Product')),
      body: Obx(() {
        return ListView.builder(
          itemCount: _controller.itemList.length,
          itemBuilder: (context, index) {
            var item = _controller.itemList[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        item['image'] ??
                            'https://cdn2.mageplaza.com/media/general/OnWj0is.png',
                        height:
                            mediaQuery.orientation == Orientation.portrait
                                ? 100
                                : 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 10,
                          bottom: 10,
                          right: 5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              item['title'] ?? 'NA',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  item['price'] ?? 'NA',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  item['originPrice'] ?? 'NA',
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 14,
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${item['unitCount']} peice' ?? 'NA',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              item['salesVolume'] ?? 'NA',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
