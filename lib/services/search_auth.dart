import 'package:buybox_app/models/response_models/search_response_model.dart';
import 'package:dio/dio.dart';

class SearchAuth {
  final dio = Dio(
    BaseOptions(
      headers: {
        'x-rapidapi-host': 'real-time-amazon-data.p.rapidapi.com',
        'x-rapidapi-key': '8b3dd176e6msha6a9238c0dda1a4p1ed968jsn889dbdd27a19',
      },
    ),
  );

  Future<List<Products>> fetchData(String query) async {
    try {
      final response = await dio.get(
        'https://real-time-amazon-data.p.rapidapi.com/search?query=$query&page=1&country=IN',
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
