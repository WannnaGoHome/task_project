import 'package:flutter/material.dart';
import 'package:practise/data/router/task_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practise/data/repositories/user_repository.dart';
import 'package:practise/core/di/service_locator.dart';

void main() async {
  final userRepository = UserRepository();
  
  WidgetsFlutterBinding.ensureInitialized();
  await userRepository.initializeUsers();
  configureDependencies();
  runApp(
      MyApp(),
  );
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
