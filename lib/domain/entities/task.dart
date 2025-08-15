// domain/entities/task.dart
// этот файл обозначает сущность Task - то есть
// параметры которые содержит этот объект

import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final String id;
  final String title;
  final String description;
  bool isCompleted;

  Task({required this.id, required this.title, required this.description, this.isCompleted = false});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

// поняла для чего нам это надо. Чтобы можно было создавать копии объекта. изменяя только некоторые свойства
  Task copyWith(
    {String? id, String? title, String? description, bool? isCompleted}
    ) {
    //а здесь я создаю экземпляр класса Task, в который передаю либо поле из параметров, либо,
    //если оно null, то передаём текущее поле объекта. Это нужно чтобы не переписывать объекты класса полностью, чтобы
    //можно было создать новый объект, изменив только одно поле, а остальное скопировать у другого объекта
    //тогда это записывается вот так: 
      //const task1 = Task(id: "id_1", title: "Task1_title", isCompleted: true);
    //если бы я делала без copyWith, то я бы сделала так
      //final task2 = Task(id: "id_1", title: "Task1_title", isCompleted: false);
    //но copyWith помогает создать новый объект через конструктор, в данном случае
    //изменённую копию экземпляра task1, в которой не переданные параметры 
    //автоматически будут скопированы в новый объект. Вот так:
    // final task2 = task1.copyWith(isCompleted:true);
    //- я передала только один параметр, а остальные будут взяты из task1

    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
  return 'Task(ID Задачи: $id, Название: $title, Описание: $description, Статус: $isCompleted) хихихаха';
}

}

