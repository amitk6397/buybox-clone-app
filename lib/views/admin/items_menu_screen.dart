import 'package:buybox_app/controllers/home_page_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:buybox_app/views/admin/product_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsMenuScreen extends StatefulWidget {
  const ItemsMenuScreen({super.key});

  @override
  State<ItemsMenuScreen> createState() => _ItemsMenuScreenState();
}

class _ItemsMenuScreenState extends State<ItemsMenuScreen> {
  final HomePageController _controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/cooking_background.webp'),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        mediaQuery.orientation == Orientation.portrait ? 2 : 4,
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 20,
                  ),
                  children: [
                    card(context, _controller, 0),
                    card(context, _controller, 1),
                    card(context, _controller, 2),
                    card(context, _controller, 3),
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(height: 150, child: card(context, _controller, 4)),
                SizedBox(height: 40),
                GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        mediaQuery.orientation == Orientation.portrait ? 2 : 4,
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 20,
                  ),
                  children: [
                    card(context, _controller, 5),
                    card(context, _controller, 6),
                    card(context, _controller, 7),
                    card(context, _controller, 8),
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(height: 150, child: card(context, _controller, 9)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget card(BuildContext context, HomePageController _controller, int index) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => ProductMenu(
                tableName: _controller.categoryImage[index]['name'],
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
