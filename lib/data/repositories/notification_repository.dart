// lib/data/repositories/notification_repository.dart

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

class NotificationRepository {
  final FlutterLocalNotificationsPlugin localNotificationsPlugin;
  //callback - это функция, которая передается в другую функцию и 
  //вызывается когда происходит определенное событие.
  Function(String)? onNotificationMessage;

  NotificationRepository(this.localNotificationsPlugin);

  Future<void> initialize({
    String? defaultIcon,
    List<AndroidNotificationChannel> channels = const [],
  }) async {
    const androidSettings = AndroidInitializationSettings('ic_notification');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await localNotificationsPlugin.initialize(initializationSettings);

    for (final channel in channels) {
      await localNotificationsPlugin.
        resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    }
  }

  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
    String? channelId = 'high_importance_channel',
    String? channelName = 'High Importance Notifications',
  }) async {
    await localNotificationsPlugin.show(id, title, body,
    NotificationDetails(
      android: AndroidNotificationDetails(
          channelId!,
          channelName!,
          channelDescription: 'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
        ),
      iOS: const DarwinNotificationDetails(),
    ),
    );
  }

  Future<void> scheduleNotification({
    required int id, 
    required String title, 
    required String body,
    required TZDateTime scheduledDate,
    String? channelId = 'high_importance_channel',
    String? channelName = 'High Importance Notifications',
    }) async {
    await localNotificationsPlugin.zonedSchedule(
      id, 
      title, 
      body, 
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
        channelId!, channelName!,
        channelDescription: 'Reminder to complete the task',
        importance: Importance.max,
        priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> cancelNotification(int id) async {
    await localNotificationsPlugin.cancel(id);
  }
  
  Future<void> cancelAllNotifications() async {
    await localNotificationsPlugin.cancelAll();
  }

  //TODO отдельно отработать нажатия уведомлений при foreground, background и terminated
  Future<void> showAppState() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage(); //из закрытого состояния
    if (initialMessage != null) {
      handleMessage(initialMessage, 'terminated');
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) { //из фона
      handleMessage(message, 'background');
    });

    FirebaseMessaging.onMessage.listen((message) { //из приложения
      handleMessage(message, 'foreground');
    });
  }
  
  void handleMessage(RemoteMessage message, String state) {
    final logMessage = 'App opened from notification when state was: ${state.toUpperCase()}. Message: ${message.notification?.body}';
    log(logMessage);
    //если получено logMessage сделай что-то
    onNotificationMessage?.call(logMessage);
  }
  
}