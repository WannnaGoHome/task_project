// models/profile_model.dart
// В модели я управляю состоянием задач, используя интерактор для загрузки, 
// сохранения и обновления пользователей

import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:practise/interactors/user_interactor.dart';
import 'package:practise/domain/entities/user.dart';


class UserModel extends ElementaryModel with ChangeNotifier {
  final UserInteractor interactor;

  UserModel(this.interactor);

  // Загружаем пользователей из файла и обновляем состояние
  Future<List<User>> loadUsers() async {
    return await interactor.load();
  }

  // Сохраняет переданный список задач в JSON
  Future<void> save(List<User> users) async {
    await interactor.save(users);
  }

}
