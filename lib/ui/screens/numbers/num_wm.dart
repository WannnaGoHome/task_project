import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:practise/core/di/service_locator.dart';
import 'package:practise/data/repositories/number_repository.dart';
import 'num_model.dart';
import 'num_screen.dart';
import 'package:injectable/injectable.dart';


@injectable
class NumbersWidgetModel extends WidgetModel<NumbersScreen, NumbersModel>
{
  final TextEditingController numberController;
  final StateNotifier<String> factText;
  final NumberRepository numberRepository;

    //TODO DIO Interceptor и логирование запроса и ответа
    // Interceptor (перехватчик) — это как секретарь для ваших HTTP-запросов. 
    // Он стоит между вашим приложением и сервером, проверяет и изменяет все запросы и ответы.
    // Без Interceptor: Вы сами звоните в банк → говорите оператору данные → получаете ответ
    // С Interceptor: У вас есть личный помощник, который:
      // Автоматически добавляет ваш ID ко всем запросам
      // Проверяет все ответы на ошибки
      // Обновляет токены, когда они устаревают


  // TODO dio_smart_retry
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
  return NumbersWidgetModel(
    NumbersModel(),
    getIt<NumberRepository>(),
  );
}
