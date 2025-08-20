// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('Запрос: ${options.method} ${options.uri}');
    print('Данные: ${options.data}');
    print('Заголовки: ${options.headers}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Ответ: ${response.statusCode} ${response.statusMessage}');
    print('Данные ответа: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('Ошибка: ${err.type}');
    print('Данные: ${err.message}');
    print('Код ошибки: ${err.response?.statusCode}');
    super.onError(err, handler);
  }
}