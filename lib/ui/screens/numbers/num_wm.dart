// ignore_for_file: avoid_print

import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:practise/core/di/service_locator.dart';
import 'package:practise/data/repositories/number_repository.dart';
import 'num_model.dart';
import 'num_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart';


@injectable
class NumbersWidgetModel extends WidgetModel<NumbersScreen, NumbersModel>
{
  final TextEditingController numberController;
  final StateNotifier<String> factText;
  final NumberRepository numberRepository;

  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

    //TODO done DIO Interceptor и логирование запроса и ответа
    // Interceptor (перехватчик) — это как секретарь для ваших HTTP-запросов. 
    // Он стоит между вашим приложением и сервером, проверяет и изменяет все запросы и ответы.
    // Без Interceptor: Вы сами звоните в банк → говорите оператору данные → получаете ответ
    // С Interceptor: У вас есть личный помощник, который:
      // Автоматически добавляет ваш ID ко всем запросам
      // Проверяет все ответы на ошибки
      // Обновляет токены, когда они устаревают
    // Зачем нужны Interceptors?
      // 1. Авторизация - Request Interceptor
      // class AuthInterceptor extends Interceptor {
      //   @override
      //   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
      //     options.headers['Authorization'] = 'Bearer ваш_токен_тут';
      //     super.onRequest(options, handler);
      //   }
      // }
      // 2. Логирование - Request Interceptor, Response Interceptor
      // class LoggingInterceptor extends Interceptor {
      //   @override
      //   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
      //     print('→ Запрос: ${options.method} ${options.uri}');
      //     super.onRequest(options, handler);
      //   }

      //   @override
      //   void onResponse(Response response, ResponseInterceptorHandler handler) {
      //     print('← Ответ: ${response.statusCode} ${response.data}');
      //     super.onResponse(response, handler);
      //   }
      // }
      // 3. Обработка ошибок - Error Interceptor
      // class TokenRefreshInterceptor extends Interceptor {
      //   @override
      //   void onError(DioException err, ErrorInterceptorHandler handler) async {
      //     if (err.response?.statusCode == 401) {
      //       // Токен устарел - обновляем
      //       final newToken = await refreshToken();
      //       // Повторяем запрос с новым токеном
      //       err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
      //       final response = await dio.fetch(err.requestOptions);
      //       return handler.resolve(response);
      //     }
      //     super.onError(err, handler);
      //   }
      // }

  // TODO done dio_smart_retry
  // TODO local_notifications 
    
  @factoryMethod
  NumbersWidgetModel(
    NumbersModel model,
    this.numberRepository,) 
      : numberController = TextEditingController(),
        factText = StateNotifier<String>(initValue: 'Здесь будет ваш факт'),
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    init();
  }

  Future<void> init() async {
    initializeTimeZones();

    setLocalLocation(
      getLocation('Asia/Almaty'),
    );
    const androidSettings = AndroidInitializationSettings('ic_notification');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await notificationsPlugin.initialize(initializationSettings);

  }

  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await notificationsPlugin.show(id, title, body,
    const NotificationDetails(
      android: AndroidNotificationDetails('instant_notificaton_channe_id', "Instant Notifications",
      channelDescription: 'Instant notification channel',
      importance: Importance.max,
      priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    ),
    );
  }

  void showSnackBar(String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
  bool isLoading = false;

  void onShowFactPressed() async {
    if (isLoading){
      return;
    }
    final number = int.tryParse(numberController.text);
    if (number != null) {
     isLoading = true;
      final fact = await numberRepository.fetchMathFact(number);
      if(fact != null) {
        factText.accept(fact);
        showInstantNotification(id: 0, title: 'Факт №$number', body: fact);
      }
      else {
        showSnackBar('Не удалось получить факт');
      }
      isLoading = false;
    }
    else{
      showSnackBar('Enter a number');
    }
  }

  void onRandomFactPressed() async {
    if (isLoading){
      return;
    }
    isLoading = true;
    final fact = await numberRepository.fetchRandomTrivia();
    if (fact != null) {
      factText.accept(fact);
    }
    else {
      showSnackBar('Не удалось получить факт');
    }
    isLoading = false;
  }

  void onGetErrorPressed() async {
    print('🔄 Тестируем Smart Retry...');
    try {
      final response = await numberRepository.getServerError();
      if (response!= null) {
        print('Ошибка 500');
      }
    } catch (e) {
      print('❌ Исключение после всех попыток retry: $e');
    }
  }


  
}

NumbersWidgetModel createNumbersWidgetModel(BuildContext context) {
  return NumbersWidgetModel(
    NumbersModel(),
    getIt<NumberRepository>(),
  );
}
