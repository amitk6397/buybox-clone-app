import 'dart:convert';

import 'package:buybox_app/models/response_models/fruits_response_model.dart';
import 'package:flutter/services.dart';

class FruitsService {
  Future<List<FruitsResponseModel>> getData() async {
    final String response = await rootBundle.loadString(
      'assets/json/fruits_json.json',
    );
    final data = json.decode(response);
    final List items = data['data'];
    return items.map((e) => FruitsResponseModel.fromJson(e)).toList();
  }
}
