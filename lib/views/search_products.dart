import 'package:buybox_app/controllers/add_remove_cart_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/controllers/search_items_controller.dart';
import 'package:buybox_app/controllers/serach_screen_item_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/category_components.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProducts extends StatefulWidget {
  const SearchProducts({super.key});

  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  final SearchItemsController _controller1 = Get.put(SearchItemsController());
  final SerachScreenItemController _controller = Get.find();
  final AddRemoveCartController _controller2 = Get.find();
  final NavigationbarController _controller3 = Get.find();
  final TextEditingController searchController = TextEditingController();
  final focusNode = FocusNode();

  bool isPlay = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Obx(() {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_controller.isPlay.value) {
                          FocusScope.of(context).unfocus();
                          searchController.clear();
                          _controller.iconChange(false);
                        } else {
                          Get.back();
                        }
                      },
                      child: Icon(
                        !_controller.isPlay.value
                            ? Icons.arrow_back
                            : Icons.close,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        onTap: () {
                          _controller.iconChange(true);
                        },
                        focusNode: focusNode,
                        controller: searchController,
                        onSubmitted: (String value) {
                          _controller1.fetchData(value.trim());
                          _controller.addText(value.trim());
                          searchController.text = '';
                          _controller.iconChange(false);
                        },

                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search product',
                          suffixIcon: PopupMenuButton(
                            icon: Icon(
                              Icons.filter_alt,
                              color: AppColors.green,
                            ),
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  child: Text('Fruits'),
                                  value: 'fruits',
                                ),
                                PopupMenuItem(
                                  child: Text('Vegetable'),
                                  value: 'veg',
                                ),
                                PopupMenuItem(
                                  child: Text('Chicken'),
                                  value: 'chicken',
                                ),
                                PopupMenuItem(
                                  child: Text('Chocolates'),
                                  value: 'choco',
                                ),
                                PopupMenuItem(
                                  child: Text('Rice'),
                                  value: 'rice',
                                ),
                                PopupMenuItem(
                                  child: Text('Atta'),
                                  value: 'atta',
                                ),
                                PopupMenuItem(
                                  child: Text('Clothes'),
                                  value: 'cloth',
                                ),
                                PopupMenuItem(
                                  child: Text('Mobile'),
                                  value: 'mobile',
                                ),
                                PopupMenuItem(
                                  child: Text('Watch'),
                                  value: 'watch',
                                ),
                                PopupMenuItem(child: Text('Oil'), value: 'oil'),
                              ];
                            },
                          ),

                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.green),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.green),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.green),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Search', style: searchScreenText()),
                  textButton(
                    () {
                      _controller.searchText.clear();
                    },
                    'Clear All',
                    Colors.orange,
                    14,
                  ),
                ],
              ),
            ),
            Obx(() {
              var items = _controller.searchText;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight:
                        items.isEmpty
                            ? 0
                            : items.length == 1
                            ? 50
                            : items.length == 1
                            ? 80
                            : 150,
                  ),
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    children: List.generate(_controller.searchText.length, (
                      index,
                    ) {
                      return GestureDetector(
                        onTap: () {
                          _controller1.fetchData(_controller.searchText[index]);
                          searchController.text = _controller.searchText[index];
                        },
                        child: ListTile(
                          leading: Icon(Icons.history),
                          title: Text(_controller.searchText[index]),
                          trailing: GestureDetector(
                            onTap: () {
                              _controller.searchText.removeAt(index);
                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.grey,
                              child: Icon(
                                Icons.close,
                                color: AppColors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              );
            }),
            Divider(),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Similar Product', style: searchScreenText()),
                  Row(
                    children: [
                      Text(
                        'Newest',
                        style: TextStyle(
                          color: AppColors.ligthGreen,
                          fontSize: 15,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            itemsWidget(_controller1, _controller2, _controller3, mediaQuery),
          ],
        ),
      ),
    );
  }
}
