// lib/core/di/service_locator.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'service_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', //назвала генерируемую функцию init()
  preferRelativeImports: true, //используем относительные импорты вместо абсолютных 
  asExtension: false, //отключаем генерацию метода как extension-метода для GetIt
)


void configureDependencies() {
  getIt.registerSingleton<Dio>(Dio()); //я отдельно регистрирую Дио
  init(getIt);
} 

//Без Injectable было бы так:
//void configureDependencies() {
//   // 1. Dio (для работы с сетью)
//   getIt.registerSingleton<Dio>(Dio());

//   // 2. API клиент (Retrofit)
//   getIt.registerSingleton<NumberApi>(
//     NumberApi(getIt<Dio>()),
//   );

//   // 3. репозиторий
//   getIt.registerSingleton<NumberRepository>(
//     NumberRepositoryImpl(getIt<NumberApi>()),
//   );

//   // 4. Регистрируем WidgetModelFactory
//   getIt.registerFactory<NumbersWidgetModel>(
//     () => NumbersWidgetModel(
//       NumbersModel(),
//       getIt<NumberRepository>(),
//     ),
//   );
// }


// Аспект	          Без get_it	                          С get_it
// Регистрация	    Ручная передача зависимостей	        Автоматическая через injectable
// Тестирование	    Сложное (переписывать конструкторы)	  Простое (подмена через registerOverride)
// Виджеты	        Зависимости через конструкторы	      Доступ через WidgetModel
// Время жизни	    Контролируется вручную	              Чёткие правила (singleton/factory)
// Гибкость	        Требует рефакторинга для изменений	  Можно менять реализации в runtime


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
