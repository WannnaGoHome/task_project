import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:practise/core/interceptors/logging_interceptor.dart';

class DioSetup {
  static Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: 'http://numbersapi.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));

    dio.interceptors.addAll([
      createRetryInterceptor(),
      LoggingInterceptor(),
    ]);

    return dio;
  }

  static RetryInterceptor createRetryInterceptor() {
    return RetryInterceptor(
      dio: Dio(),
      logPrint: print,
      retries: 3,
      retryDelays:  const [
        Duration(seconds: 1),
        Duration(seconds: 2),
        Duration(seconds: 3),
      ],
      retryEvaluator:(error, attempt) {
        return error.type == DioExceptionType.connectionTimeout ||
                error.type == DioExceptionType.receiveTimeout ||
                error.response?.statusCode == 500 ||
                error.response?.statusCode == 502 ||
                error.response?.statusCode == 503 ||
                error.response?.statusCode == 504;
      },
    );
  }
}