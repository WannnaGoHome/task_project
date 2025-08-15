// interactors/task_interactor.dart
// Здесь в интеракторе я подключаю репозиторий и создаю методы
// для отображения и изменения задач

import 'package:practise/data/repositories/task_repository.dart';
import 'package:practise/domain/entities/task.dart';


class TaskInteractor {
  final TaskRepository _repository;

  TaskInteractor(this._repository);

  // Загружает задачи из JSON
  Future<List<Task>> load() async {
    return await _repository.loadTasks();
  }

  // Сохраняет переданный список задач в JSON
  Future<void> save(List<Task> tasks) async {
    await _repository.saveTasks(tasks);
  }

}
