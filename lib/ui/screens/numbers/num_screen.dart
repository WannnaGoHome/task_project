// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'num_wm.dart';


@RoutePage()
class NumbersScreen extends ElementaryWidget<NumbersWidgetModel> {
  const NumbersScreen({super.key}) : super(createNumbersWidgetModel);

  @override
  Widget build(NumbersWidgetModel wm) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 248, 131, 170),
        foregroundColor: Colors.white,
        title: Text(
          "Факты о цифрах",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: wm.numberController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                color: Colors.pink[900],
                fontSize: 18.sp,
              ),
              decoration: InputDecoration(
                labelText: 'Введите число',
                labelStyle: GoogleFonts.montserrat(
                  color: Colors.pink[700],
                  fontSize: 14.sp,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.pinkAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.pinkAccent.withOpacity(0.4)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.pinkAccent, width: 2),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            StateNotifierBuilder<String>(
              listenableState: wm.factText,
              builder: (_, fact) {
                return Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    fact ?? 'Здесь будет ваш факт',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.montserrat(
                      height: 1.4,
                      color: Colors.pink[900],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 25.h),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 136, 210, 194),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 2,
              ),
              onPressed: () {
                wm.onShowFactPressed();
              },
              child: Text(
                'Узнать факт',
                style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),

            SizedBox(height: 12.h),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 248, 131, 170),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 2,
              ),
              onPressed: () {wm.onRandomFactPressed();},
              child: Text(
                'Рандомный факт',
                style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //TODO Dependency Injection 
  //- это техника, при которой объекты получают свои 
  // зависимости извне, а не создают их самостоятельно. 
  // Это делает код более модульным и упрощает тестирование.

  //   Пример без DI: 
    //   final Database _db = Database(); // Зависимость создаётся внутри класса
    //   void getUser() {
    //     _db.query('...');
    //   }
  // Если завтра понадобится другая зависимость, то придется многое менять в классе

  //   Пример с DI:
    //   final Database _db;
    //   UserService(this._db); // Зависимость внедряется извне
    //   void getUser() {
    //     _db.query('...');
    //   }
  // Теперь классу можно передать любую зависимость, подходящую под требования. 

  // get_it -  сервис-локатор, который позволяет управлять зависимостями. Важно понимать, что get_it - 
  // это не полноценная система DI. Это как коробка для деталей LEGO. Вместо того чтобы передавать 
  // каждую деталь вручную, мы кладём их в хранилище (get_it), откуда их можно достать когда угодно. 
  
  // Разница DI и get_it:
    // DI автоматически внедряет зависимости через конструктор/методы
    // Service Locator предоставляет централизованное хранилище, откуда можно 
    // запрашивать зависимости

  //   Как пользоваться:
    // 1. Создаём хранилище:
      // final GetItBox = GetIt.instance;
    // 2. Кладём вещи в коробку:
      // A) Кладём одну зависимость на весь класс (синглтон)
      // GetItBox.registerSingleton<DependencyName>(DependencyName());
      // B) Или говорим "как попросишь - тогда сделаю" (ленивый синглтон)
      // GetItBox.registerLazySingleton<DependencyName>(() => DependencyName());
      // C) Или "каждый раз давай новый экземпляр зависимости" (фабрика)
      // GetItBox.registerFactory<DependencyName>(() => DependencyName());
    // 3. Достаём когда нужно:
      // final dependencyName = GetItBox.get<DependencyName>();

//   Q: Когда использовать фабрику, когда синглтон? 
// 1️⃣ Синглтон (registerSingleton) — "Один на всех"
// API-клиент, Глобальный State, База данных
// Когда использовать:
// Объект должен жить всё время работы приложения
// Объект тяжёлый (например, API-клиент, база данных)
// Объект хранит состояние (например, кэш, настройки)
// 2️⃣ Фабрика (registerFactory) — "Новый каждый раз"
// Корзина покупок, Модели данных, ViewModel 
// Когда использовать:
// Объект должен создаваться заново при каждом запросе
// Объект лёгкий (например, DTO, ViewModel)
// Объект не хранит состояние 
// Тип регистрации	Когда использовать?	                       Примеры
// Singleton	      Один объект на всё приложение	             API, Database, UserSession
// Factory	        Новый объект при каждом вызове	           ShoppingCart, Order, ViewModel
// LazySingleton	  Создаётся только при первом использовании	 Analytics, HeavyService

// Три подхода
// 1️⃣ Без DI (прямое создание зависимостей)
// Когда использовать:
// Очень маленькие проекты (1-2 экрана)
// Простые утилиты/хелперы без зависимостей
// Одноразовые объекты (например, DateTime.now() в методе)
// 2️⃣ Классический DI (внедрение через конструктор)
// Когда использовать:
// Бизнес-логика (сервисы, репозитории)
// Классы, которые нужно тестировать
// 3️⃣ get_it (сервис-локатор)
// Когда использовать:
// Глобальные сервисы (Auth, API, Analytics)
// Flutter-виджеты (где нельзя использовать конструкторы)
// Быстрый доступ к зависимостям "из глубины" кода

// 🔍 Разница между registerSingleton и registerLazySingleton в get_it
// Оба создают один экземпляр на всё приложение, но разница — в моменте создания объекта.
  // 1️⃣ registerSingleton — создаётся сразу
    // getIt.registerSingleton<ApiClient>(ApiClient());
  // Что происходит:
  // Объект создаётся мгновенно при регистрации.
  // Занимает память с момента старта приложения.
  // Когда использовать:
  // Объект нужен сразу (например, Router, Config).
  // Инициализация быстрая (нет долгой загрузки).
  //
  // 2️⃣ registerLazySingleton — создаётся при первом вызове
    // getIt.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
  // Что происходит:
  // Объект создаётся только при первом getIt.get<Service>().
  // Не тратит ресурсы, пока не нужен.
  // Когда использовать:
  // Объект тяжёлый (например, подключается к БД).
  // Нужен не сразу (например, только после авторизации).
    //   Пример:
     // Регистрируем, но не создаём сразу
    // getIt.registerLazySingleton<Database>(() => Database());
     // Где-то позже в коде (при первом вызове):
    // final db = getIt.get<Database>(); 

  //    Что такое injectable и зачем он нужен?
  // Injectable — это кодогенератор для get_it, который автоматизирует регистрацию
  // зависимостей. Вместо ручного прописывания registerSingleton/registerFactory 
  // он делает это на основе аннотаций.
  // Было (без injectable)
  //   void setupGetIt() {
  //     getIt.registerSingleton<Database>(Database());
  //     getIt.registerSingleton<UserRepository>(
  //       UserRepository(getIt.get<Database>()), // Вручную передаём зависимость
  //     );
  //   }
  // Стало (с injectable)
  //   @singleton
  //   class Database {}
  //   @injectable
  //   class UserRepository {
  //     final Database db;
  //     UserRepository(this.db); // Всё разрешится автоматически!
  //   }

}
