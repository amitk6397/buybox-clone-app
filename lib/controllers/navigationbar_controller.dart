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

  Widget getPage(int i) {
    switch (i) {
      case 0:
        return HomeScreen();
      case 1:
        return CategoriesPage();
      case 2:
        return ShoppingCartPage();
      case 3:
        return FavoritesItemsPage();
      case 4:
        return ProfielScreen();
      default:
        return HomeScreen();
    }
  }

  final List<GlobalKey<NavigatorState>> navigatorKeys = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );

  void changeScreen(value) {
    _index.value = value;
  }

  Future<bool> onWillPop() async {
    final currentNavigator = navigatorKeys[index.value].currentState;

    if (currentNavigator != null && currentNavigator.canPop()) {
      currentNavigator.pop();
      return false;
    }

    if (index.value != 0) {
      index.value = 0;
      return false;
    }

    return true;
  }
}
