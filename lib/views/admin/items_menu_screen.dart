import 'package:buybox_app/controllers/home_page_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/category_components.dart';
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
                    card(_controller, null, 0),
                    card(_controller, null, 1),
                    card(_controller, null, 2),
                    card(_controller, null, 3),
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(height: 150, child: card(_controller, null, 4)),
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
                    card(_controller, null, 5),
                    card(_controller, null, 6),
                    card(_controller, null, 7),
                    card(_controller, null, 8),
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(height: 150, child: card(_controller, null, 9)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
