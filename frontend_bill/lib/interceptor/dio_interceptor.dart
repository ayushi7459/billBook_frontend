import 'package:dio/dio.dart';
import 'package:general/storage/flutter_secure_storage.dart';

class DioInterceptor extends Interceptor {
  final _secureStorage = MySecureStorage();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      'Content-Type': 'application/json',
    });

    final token = await _secureStorage.readToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    print('Request Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response Body: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('Error: ${err.error}');
    super.onError(err, handler);
  }
}
