import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:practise/data/repositories/number_repository.dart';
import 'num_model.dart';
import 'num_screen.dart';


class NumbersWidgetModel extends WidgetModel<NumbersScreen, NumbersModel>
{
  final numberController = TextEditingController();
  final factText = StateNotifier<String>(initValue: 'Здесь будет ваш факт');
  final numberRepository = NumberRepository();
  
    //TODO изучить flavor окружения 

    //Dev-версия — для разработчиков и тестировщиков. Прод-версия — для обычных пользователей.
    //В итоге тестовые действия попадают только в аналитику dev-версии,
    //а данные прод-версии остаются чистыми. Так мы получаем точную 
    //картину того, насколько фича востребована у реальных пользователей. 
    
    // Android	               iOS
    // build types	           build configurations
    // flavors	               targets

    // Build types / build configurations — отвечают за то, как собирается приложение (например, debug, release).
    // debug — сборка для разработки: можно дебажить, есть дополнительные логи, нет жёстких оптимизаций, 
    // подписывается debug-ключом.
    // release — сборка для публикации: оптимизирована, дебаггер отключён, подписывается release-ключом.
    
    // Flavors / targets — позволяют создавать разные приложения из одной кодовой базы (например, dev и prod).
    // Это логические «варианты» приложения, которые могут иметь разные настройки и содержимое:

    // Версия	  Для кого	    Назначение	            Пример package name	         Пример иконки / цвета
    // dev	   разработчики	  тестирование, отладка	  com.example.project.dev	     с надписью DEV
    // prod	   обычные юзеры	настоящая публикация	  com.example.project	         обычная финальна

    // 👉 благодаря этому данные аналитики, клики и ошибки не смешиваются, а ещё можно:
    // показывать тестовые фичи только в dev;
    // подключать dev-сервер (test API) вместо production API;
    // иметь отдельную иконку / название (например: Numbers DEV).


  NumbersWidgetModel(NumbersModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
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

  void onShowFactPressed() async {
    final number = int.tryParse(numberController.text);
    if (number != null) {
      final fact = await numberRepository.fetchMathFact(number);
      if(fact != null) {
        factText.accept(fact);
      }
      else {
        showSnackBar('Не удалось получить факт');
      }
    }
    else{
      showSnackBar('Enter a number');
    }
  }

  void onRandomFactPressed() async {
    final fact = await numberRepository.fetchRandomTrivia();
    if (fact != null) {
      factText.accept(fact);
    }
    else {
      showSnackBar('Не удалось получить факт');
    }
  }
  
}

NumbersWidgetModel createNumbersWidgetModel(BuildContext context) {
  return NumbersWidgetModel(NumbersModel());
}

