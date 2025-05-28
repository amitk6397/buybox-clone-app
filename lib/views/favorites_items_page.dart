import 'package:buybox_app/controllers/add_remove_cart_controller.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesItemsPage extends StatefulWidget {
  const FavoritesItemsPage({super.key});

  @override
  State<FavoritesItemsPage> createState() => _FavoritesItemsPageState();
}

class _FavoritesItemsPageState extends State<FavoritesItemsPage> {
  final AddRemoveCartController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),

            title: Text('Favorites Items', style: appBarText(AppColors.green)),
            trailing: appBackButton(AppColors.green, Icons.more_vert, () {}),
          ),
          Obx(() {
            return Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                children: List.generate(_controller.favItems.length, (index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          _controller.favItems[index].image,
                        ),
                      ),
                      title: Text(
                        _controller.favItems[index].title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(_controller.favItems[index].price),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ],
      ),
    );
  }
}
