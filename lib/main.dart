 import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:practise/data/repositories/notification_repository.dart';
import 'package:practise/data/router/task_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practise/data/repositories/user_repository.dart';
import 'package:practise/core/di/service_locator.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  final userRepository = UserRepository();
  WidgetsFlutterBinding.ensureInitialized();

  await userRepository.initializeUsers();
  configureDependencies();

  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  log(app.options.projectId);
  final messaging = FirebaseMessaging.instance;
  messaging.getToken().then((token) => log(token ?? 'Нет токена')); //FCM 
  
  final notificationRepository = getIt<NotificationRepository>();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  await notificationRepository.initialize(channels: [channel]);
  
  //TODO вывести firebase messaging через flutter local notifications

  //onMessage. Возвращает поток, который вызывается при получении входящей полезной 
  //нагрузки FCM, когда экземпляр Flutter находится на переднем плане.
  //Поток содержит [RemoteMessage].

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;
    
    if (notification != null && android !=null) {
      String title = "Foreground ${notification.title ?? ''}";
      String body = notification.body ?? '';
    
    notificationRepository.showInstantNotification(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title: title,
      body: body
    );
    
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'TO-DO Application',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          scaffoldBackgroundColor: Colors.pink[50],
        ),
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
