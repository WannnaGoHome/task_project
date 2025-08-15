// interactors/user_interactor.dart
// Здесь в интеракторе я подключаю репозиторий и создаю методы
// для отображения и изменения пользователей

import 'package:practise/data/repositories/user_repository.dart';
import 'package:practise/domain/entities/user.dart';

class UserInteractor {
  final UserRepository _repository;

  UserInteractor(this._repository);

  // Загружает задачи из JSON
  Future<List<User>> load() async {
    return await _repository.loadUsers();
  }

  // Сохраняет переданный список задач в JSON
  Future<void> save(List<User> users) async {
    await _repository.saveUsers(users);
  }

}
