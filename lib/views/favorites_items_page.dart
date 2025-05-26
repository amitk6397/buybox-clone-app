import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/common_button.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:flutter/material.dart';

class FavoritesItemsPage extends StatefulWidget {
  const FavoritesItemsPage({super.key});

  @override
  State<FavoritesItemsPage> createState() => _FavoritesItemsPageState();
}

class _FavoritesItemsPageState extends State<FavoritesItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: appBackButton(AppColors.green, Icons.arrow_back, () {}),
            title: Text('Favorites Items', style: appBarText(AppColors.green)),
            trailing: appBackButton(AppColors.green, Icons.more_vert, () {}),
          ),
        ],
      ),
    );
  }
}
