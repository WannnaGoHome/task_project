// models/task_model.dart
// В модели я управляю состоянием задач, используя интерактор для загрузки, 
// сохранения и обновления, а также фильтрую задачи по статусу

import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:practise/interactors/task_interactor.dart';
import 'package:practise/domain/entities/task.dart';


class TaskModel extends ElementaryModel with ChangeNotifier {
  final TaskInteractor interactor;

  TaskModel(this.interactor);

  // Загружаем задачи из файла и обновляем состояние
  Future<List<Task>> loadTasks() async {
    return await interactor.load();
  }

  // Сохраняем задачи
  Future<void> saveTasks(List<Task> tasks) async {
    await interactor.save(tasks);
  }

}
