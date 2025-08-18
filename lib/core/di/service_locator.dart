// lib/core/di/service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'service_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', //назвала генерируемую функцию init()
  preferRelativeImports: true, //использовать относительные импорты вместо абсолютных 
  asExtension: false, //отключаем генерацию метода как extension-метода для GetIt
)

void configureDependencies() => init(getIt); // Это функция-обёртка, которая служит 
// единой точкой входа для инициализации DI и позволяет добавить дополнительную логику
