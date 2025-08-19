import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

// class NumberApi
// {
//   final String baseUrl = "http://numbersapi.com/";
//   final Dio _dioClient = Dio();

//   Future<Response> get(String endpoint) async {
//     String url = baseUrl + endpoint;
//     final response = await _dioClient.get(url);
//     return response;
//   }
  
// }

part 'number_api.g.dart';

@singleton
@RestApi(baseUrl: "http://numbersapi.com/")
abstract class NumberApi {

  @factoryMethod
  factory NumberApi(Dio dio) = _NumberApi;

  @GET("/{number}/math")
  Future<String> getMathFact(@Path("number") int number);

  @GET("/random/trivia")
  Future<String> getRandomTrivia();
  //TODO изучить работа с API dio, retrofit
}

// Retrofit — это как умная обёртка над Dio, которая позволяет 
// использовать HTTP-запросы как понятные обычные методы. Вместо 
// того чтобы каждый раз вручную строить URL, писать dio.get(...),
// обрабатывать ошибки, проверять statusCode, парсить JSON, ты 
// просто описываешь: «У меня есть метод getMathFact, который
// берёт число и должен вернуть текст» — и всё. Retrofit 
// автоматически подставит число в URL, отправит запрос, получит
// ответ, превратит JSON в Dart-модель (если нужно) и вернёт тебе
// результат в виде Future.

// То есть тебе остаётся только работать с методами, будто ты 
// вызываешь обычную функцию, а не делаешь сетевой запрос. Это
// делает код существенно короче и понятнее