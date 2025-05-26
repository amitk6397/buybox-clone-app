import 'package:dio/dio.dart';

class SearchInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'x-rapidapi-host': 'real-time-amazon-data.p.rapidapi.com',
      'x-rapidapi-key': '8b3dd176e6msha6a9238c0dda1a4p1ed968jsn889dbdd27a19',
    });
    print('Request ========= : ${options.method} and ${options.uri}');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response: ${response.statusCode}');
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('Error ${err.message}');
    return handler.next(err);
  }
}
