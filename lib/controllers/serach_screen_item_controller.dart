import 'package:get/get.dart';

class SerachScreenItemController extends GetxController {
  RxList<dynamic> _searchText = [].obs;

  RxList<dynamic> get searchText => _searchText;

  RxBool _isPlay = false.obs;

  RxBool get isPlay => _isPlay;

  void iconChange(bool isPlay) {
    _isPlay.value = isPlay;
  }

  void addText(String text) {
    if (!_searchText.contains(text)) _searchText.add(text);
  }

  RxList<Map<String, dynamic>> filter =
      [
        {'label': 'Fruits', 'value': 'fruits'},
        {'label': 'Vegetable', 'value': 'veg'},
        {'label': 'Chicken', 'value': 'chicken'},
        {'label': 'Chocolates', 'value': 'choco'},
        {'label': 'C', 'value': 'fruits'},
        {'label': 'Fruits', 'value': 'fruits'},
        {'label': 'Fruits', 'value': 'fruits'},
        {'label': 'Fruits', 'value': 'fruits'},
        {'label': 'Fruits', 'value': 'fruits'},
      ].obs;
}
