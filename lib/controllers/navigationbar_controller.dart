import 'package:buybox_app/views/category/categories_page.dart';
import 'package:buybox_app/views/favorites_items_page.dart';
import 'package:buybox_app/views/home/home_screen.dart';
import 'package:buybox_app/views/profile/profiel_screen.dart';
import 'package:buybox_app/views/shopping_cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationbarController extends GetxController {
  RxInt _index = 0.obs;

  RxInt get index => _index;

  RxList<Widget> _screenList =
      [
        HomeScreen(),
        CategoriesPage(),
        ShoppingCartPage(),
        FavoritesItemsPage(),
        ProfielScreen(),
      ].obs;

  RxList<Widget> get screenList => _screenList;

  void changeScreen(value) {
    _index.value = value;
  }
}
