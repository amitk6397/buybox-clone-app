import 'package:dio/dio.dart';

class SearchInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'x-rapidapi-host': 'real-time-amazon-data.p.rapidapi.com',
      'x-rapidapi-key': '29a4dde1d7mshcd6c0966cdddfabp1d139djsn0fe584e0ad40',
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
