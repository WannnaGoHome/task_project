// data/repositories/task_repository.dart
// Здесь используя сущность Task я создаю список и методы для
// хранения, загрузки и изменения данных в JSON на устройстве

import 'dart:convert';
import 'package:practise/domain/entities/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskRepository {
  static const _key = 'tasks';

  Future<List<Task>> loadTasks() async {
    //переделала сама
    //  await Future.delayed(const Duration(seconds: 5));

    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json != null) {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((e) => Task.fromJson(e)).toList();
    }
    return [];
  }


  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();


    //final encoded = jsonEncode(tasks.map((e) => e.toJson()).toList());

    //так, пошагово. Для начала, мы создаём переменную encoded, она изменяемая (final).
    //Затем мы берём первоначальный список tasks и при помощи map() преобразовываем его
    //каждый его элемент в тип Json:
    //tasks.map((e) => e.toJson())
    //Затем получается объект типа map, который мы обратно преобразовываем в список:
    //.toList(). 
    //Теперь каждый объект в этом списке-строка Json. Дальше функция 
    //jsonEncode возвращает этот список в виде строки Json 

    var mappedTasks = [];
    for (final task in tasks){
      final newTask = task.toJson();
      mappedTasks.add(newTask);
    }
    final encoded=jsonEncode(mappedTasks);
    await prefs.setString(_key, encoded);

    // Почему это делается так? Почему нельзя сразу сделать jsonEncode? 
    // Потому что при преобразовании списка объектов класса нужно сначала
    //конвертировать каждый объект индивидкально, а потом сконвертировать список из json строк

  }

}

