import 'package:buybox_app/controllers/home_page_controller.dart';
import 'package:buybox_app/controllers/navigationbar_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/category_components.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final HomePageController _controller = Get.put(HomePageController());
  final NavigationbarController _controller3 = Get.find();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert, size: 28)),
          SizedBox(width: 10),
        ],
        title: Text(
          'Categories',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
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
                    card(_controller, _controller3, 0),
                    card(_controller, _controller3, 1),
                    card(_controller, _controller3, 2),
                    card(_controller, _controller3, 3),
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(
                  height: 150,
                  child: card(_controller, _controller3, 4),
                ),
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
                    card(_controller, _controller3, 5),
                    card(_controller, _controller3, 6),
                    card(_controller, _controller3, 7),
                    card(_controller, _controller3, 8),
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(
                  height: 150,
                  child: card(_controller, _controller3, 9),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
