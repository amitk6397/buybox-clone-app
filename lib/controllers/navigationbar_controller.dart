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

  final RxList<Widget> _screenList =
      [
        HomeScreen(),
        CategoriesPage(),
        ShoppingCartPage(),
        FavoritesItemsPage(),
        ProfielScreen(),
      ].obs;

  RxList<Widget> get screenList => _screenList;

  final List<GlobalKey<NavigatorState>> navigatorKeys = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );

  void changeScreen(value) {
    _index.value = value;
  }

  Future<bool> onWillPop() async {
    final isFirstRouteInCurrentTab =
        !await navigatorKeys[index.value].currentState!.maybePop();
    if (isFirstRouteInCurrentTab) {
      // If user is on first route of current tab, maybe exit app or show a dialog
      return true; // let system handle back button
    }
    // Else pop nested navigator
    return false;
  }
}
