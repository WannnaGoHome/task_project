import 'package:dio/dio.dart';
import 'dart:developer';

class LoggingInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('Запрос: ${options.method} ${options.uri}');
    log('Данные: ${options.data}');
    log('Заголовки: ${options.headers}');
    super.onRequest(options, handler); 
    //     Dio использует цепочку интерцепторов. Каждый интерцептор должен передать запрос следующему в цепочке:


  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('Ответ: ${response.statusCode} ${response.statusMessage}');
    log('Данные ответа: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('Ошибка: ${err.type}');
    log('Данные: ${err.message}');
    log('Код ошибки: ${err.response?.statusCode}');
    super.onError(err, handler);
  }
}

