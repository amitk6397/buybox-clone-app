import 'package:buybox_app/models/response_models/search_response_model.dart';
import 'package:buybox_app/services/app_url.dart';
import 'package:buybox_app/services/search_interceptor.dart';
import 'package:dio/dio.dart';

class SearchAuth {
  final dio = Dio();
  SearchAuth() {
    dio.interceptors.add(SearchInterceptor());
  }
  Future<List<Products>> fetchData(String query) async {
    try {
      final response = await dio.get(
        '${AppUrl.baseUrl}search?query=$query&page=1&country=IN',
      );

      print('API Response: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final json = response.data;

        if (json['data'] != null && json['data']['products'] is List) {
          return (json['data']['products'] as List)
              .map((v) => Products.fromJson(v))
              .toList();
        } else {
          print("products list is missing or null");
          return [];
        }
      } else {
        print('Failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}
