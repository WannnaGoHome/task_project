
import 'dart:developer';

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
      //     log('→ Запрос: ${options.method} ${options.uri}');
      //     super.onRequest(options, handler);
      //   }

      //   @override
      //   void onResponse(Response response, ResponseInterceptorHandler handler) {
      //     log('← Ответ: ${response.statusCode} ${response.data}');
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
  // TODO firebase messaging
  //
  //Firebase это облачная платформа от гугла, которая помогает
  //быстрее добавлять в приложения какие-то функции типа аналитики
  //авторизации, мониторинга ошибок, remote config, cloud storage,
  //cloud database. Благодарчя нему не нужно самостоятельно 
  //писать свой сервис аналитики, авторизации, хранения данных  

//   Преимущества Firebase Messaging (FCM)
  // 1. Бесплатная и надёжная доставка пушей
  // FCM полностью бесплатен (в отличие от многих сторонних сервисов).
  // Работает на глобальной инфраструктуре Google → высокая стабильность доставки сообщений.
  // Поддерживает миллионы пользователей одновременно.

  // 2. Поддержка разных типов сообщений
  // Notification messages — простые уведомления (title, body, иконка). Android сам их показывает, если приложение в фоне.
  // Data messages — только полезная нагрузка (data: {...}), которую обрабатываешь сам в Dart/Kotlin/Java.
  // Смешанные сообщения (и notification, и data вместе).

  // 👉 Это позволяет:
  // показывать простые уведомления "из коробки",
  // или делать сложные сценарии (например, синхронизация данных, кастомные уведомления).

  // 3. Работа в фоне и при закрытом приложении
  // Даже если пользователь закрыл приложение → FCM может "разбудить" его сервис и показать пуш.
  // Для data-сообщений можно зарегистрировать обработчик onBackgroundMessage.

  // 4. Гибкая сегментация и таргетинг
  // Можно отправлять пуши:
  // на конкретные устройства (по FCM-токену),
  // на группы устройств,
  // по темам (subscribeToTopic("news")),
  // через условия (например: "topicA" && !"topicB").
  // В консоли Firebase можно настроить кампании без бэкенда.

  // 5. Интеграция с другими сервисами Firebase
  // Firebase Analytics — отслеживание открытий пушей, CTR и т.д.
  // Firebase A/B Testing — можно запускать эксперименты с пушами (например, тестировать разные тексты).
  // Firebase Remote Config — менять контент пушей в зависимости от параметров приложения.

  // 6. Поддержка разных платформ
  // Android, iOS, Web → можно отправлять сообщения во все приложения с одного сервера.
  // Не нужно писать отдельные реализации под каждую ОС.

  // 7. Масштабируемость и простота
  // Нет необходимости поддерживать свой сервер уведомлений (Google берёт это на себя).
  // Достаточно знать FCM токен устройства → и можно отправлять пуш.

  // 🔹 Когда FCM особенно полезен
    // Если приложение должно напоминать (чаты, таск-менеджеры, заметки).
    // Если нужно рассылать уведомления группам пользователей.
    // Если важно держать пользователей вовлечёнными (акции, новости).
    // Если хочешь минимизировать расходы (бесплатно и масштабируемо).


    
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
    log('🔄 Тестируем Smart Retry...');
    try {
      final response = await numberRepository.getServerError();
      if (response!= null) {
        log('Ошибка 500');
      }
    } catch (e) {
      log('❌ Исключение после всех попыток retry: $e');
    }
  }


  
}

NumbersWidgetModel createNumbersWidgetModel(BuildContext context) {
  return NumbersWidgetModel(
    NumbersModel(),
    getIt<NumberRepository>(),
  );
}
