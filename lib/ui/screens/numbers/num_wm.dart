
import 'dart:developer';

import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:practise/core/di/service_locator.dart';
import 'package:practise/data/repositories/notification_repository.dart';
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
  final NotificationRepository _notificationRepository;
 
  @factoryMethod
  NumbersWidgetModel(
    NumbersModel model,
    this._notificationRepository,
    this.numberRepository,) 
      : numberController = TextEditingController(),
        factText = StateNotifier<String>(initValue: 'Здесь будет ваш факт'),
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  } 

  
  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await _notificationRepository.showInstantNotification(id: id, title: title, body: body,
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
    getIt<NotificationRepository>(),
    getIt<NumberRepository>(),
  );
}