import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:practise/core/di/service_locator.dart';
import 'package:practise/data/repositories/notification_repository.dart';
import 'package:practise/data/router/task_router.dart';
import 'package:timezone/timezone.dart';
import 'task_model.dart';
import '../../../domain/entities/task.dart';
import 'task_screen.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:practise/data/repositories/task_repository.dart';
import 'package:practise/interactors/task_interactor.dart';

class TaskScreenWM extends WidgetModel<TaskScreen, TaskModel> {
  final currentTabIndex = StateNotifier<int>(initValue: 0);
  final isLoading = StateNotifier<bool>(initValue: false);
  final TaskRepository _repository;
  final _tasksState = StateNotifier<List<Task>>(initValue: const []);
  final _taskCounts = StateNotifier<Map<String, int>>(initValue: {'active': 0, 'completed': 0});
  final NotificationRepository _notificationRepository;

  StateNotifier<Map<String, int>> get taskCounts => _taskCounts;
  StateNotifier<List<Task>> get tasksState => _tasksState;
  
  TaskScreenWM(super.model, 
  this._repository,
  this._notificationRepository
  );

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    loadTasks().then((_) {
    updateTaskSummary(tasksState.value ?? []);
  });
  }

  void updateTaskSummary(List<Task> tasks) {
    final active = tasks.where((t) => !t.isCompleted).length;
    final completed = tasks.where((t) => t.isCompleted).length;
    _taskCounts.accept({'active': active, 'completed': completed});
  }

  Future<void> loadTasks() async {
  final loaded = await _repository.loadTasks();
  _tasksState.accept(loaded);
}

  /// Переключение вкладки (0 — активные, 1 — завершённые)
  void onTabChanged(int index) => currentTabIndex.accept(index);

  /// Добавление новой задачи
  void onAdd(String title, String description, DateTime deadline) {
    final curTasks = List<Task>.from(tasksState.value ?? []);
    final task = Task(id: DateTime.now().toIso8601String(), title: title, description: description, deadline: deadline);
    curTasks.add(task);
    tasksState.accept(curTasks);
    updateTaskSummary(curTasks);
    model.saveTasks(curTasks);
    
    log('Задача добавлена: $task');
  }

  String get tasksCount {
    final counts = taskCounts.value;
    return '(${counts?['active'] ?? 0}/${counts?['completed'] ?? 0})';
  }

  /// Переключение статуса выполнения
  void onToggle(String id) {
    final curTasks = List<Task>.from(
      tasksState.value ?? []);
    final index = curTasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      final task = curTasks[index];
      curTasks[index] = task.copyWith(isCompleted: !task.isCompleted);
      tasksState.accept(curTasks);
      updateTaskSummary(curTasks);
      model.saveTasks(curTasks);
      
      log('Изменён статус задачи: $task');
    }
  }


// поняла чем отличается List, Set и Iterable
// Use a List:
// You need an ordered collection of elements.
// You need to access elements by index.
// Duplicate elements are allowed.
// You want a dynamic-size collection.
  // List<String> fruits = ['apple', 'banana', 'orange'];
// Use a Set when:
// You need an unordered collection of unique elements.
// You want to ensure that elements are distinct.
// You don't need to access elements by index.
//   Set<String> uniqueFruits = {'apple', 'banana', 'orange'};
// Use a Map when:
// You need to associate keys with values.
// You want to perform lookups based on keys.
// You want a key-value pair data structure.
  // Map<String, int> ages = {'Alice': 25, 'Bob': 30, 'Charlie': 22};
// Use an Iterable when:
// You want to represent a sequence of elements that can be iterated.
// You want to use common iterable operations like forEach, map, where, etc.
// You don't need direct access to elements by index.
// You are creating custom iterable classes.
  // Iterable<int> countdown = CountdownIterable(5, 1);

// 16.07 изучить Asynchronous programming future async await АААААА БЕСИТ
// Зачем нужна и асинхронность? Во FLutter при запуске программы
//основной поток обрабатывает все события пользовательского интерфейса 
//- нажатие кнопок, касания экрана и т.д. Однако приложение должно
//не только последовательно отправлять и обрабатывать запросы интерфейса,
//но и параллельно обращаться к серверу по другим задачам.
//Запрос может занимать большое количество времени, особенно
//в условиях нестабильной работы интернета. Однако они отправляются
//так, что пользователю не нужно ждать, пока обработается запрос для
//продолжения взаимодействия с интерфейсом. Мы можем отправить
//письмо и тут же начать писать новое без зависаний потому, что сетевой
//запрос производится асинхронно. А когда он будет выполнен, мы просто
//можем увидеть уведомление. В этом и преимущество применения
//асинхронности. Это касается любых задач которые занимают
//продолжительное время.
//Dart может выполнять только одну задачу в одно время. Тем не менее
//благодаря реализации цикла событий (event loop) и двух очередей
//событий (event queue и microTask queue) он позволяет асинхронно
//выполнять различные задачи.
//1. Единственный поток приложения инициализирует две очереди - MicroTask и Event,
//которые будут содержать задачи, которые необходимо будет выполнить. Сначала поток
//запускает все синхронные задачи из функции main(). Если Dart встречает
//сложную задачу, выполнение которой можно отложить, она помещается в Event Queue.
//2. После этого цикл событий (Event Loop) проверяет очередь Microtask Queue и
//помещает задачи из неё в основной поток для последующего выполнения.
//3. Затем цикл событий начинает выбирать задачи из очереди Event Queue и помещает
//их в основной поток, где они выполняются синхронно.
// Ключевым классом для определения асинхронных задач является класс Future. Он
//представляет результат отложенной операции, которая завершит свое выполнение в
//будущем. Результатом может быть некоторое значение или ошибка.
//Объект Future может находиться в двух состояниях: Uncompleted и Completed. В
//незавершенном состоянии операция уже начала выполняться, но результат еще не
//получен. В завершенном состоянии операция завершила выполнение,результат получен:
// Future getMessage() {
//   return Future.delayed(Duration(seconds: 3), () => log("Пришло новое сообщение от Тома"));
// }
//Асинхронная функция - это такая функция, которая содержит как минимум одну асинхронную операцию
//Она выглядит как синхронная за исключением использования операторов async и await.
//Асинхронная функция выполняет синхронно весь код, который идет до первого вызова выражения await.
//Выражение await представляет асинхронную операцию. Уже после того, как из выражения await мы
//получили значение, функция продолжает свое выполнение и переходит к выполнению оставшегося кода.
//Также стоит отметить, что асинхронная функция может содержать несколько выражений await. В
//этом случае они выполняется последовательно: когда завершится предыдущее, начинает выполняться
//последующее выражение await.
// Что делает await:
// При встрече await, выполнение текущей функции (текущего стека) приостанавливается (то есть, эта функция временно "замораживается").
// Но! Вся остальная программа не приостанавливается — main() продолжает работать, другие функции могут выполняться.
// Когда Future завершился, Dart автоматически возобновляет выполнение функции с места, где был await:
  // Начало функции doWork
  // Выполнение функции main
  // Получено сообщение: Hello Dart
  // Завершение функции doWork

// Конструкторы сFuture
// Future(FutureOr<T> computation()): создает объект future, который с помощью метода Timer.run запускает функцию computation асинхронно и возвращает ее результат.
// Тип FutureOr<T> указывает, что функция computation должна возвращать либо объект Future<T> либо объект типа T. Например, чтобы получить объект Future<int>, функция computation должна возвращать либо объект Future<int>, либо объект int
// Future.delayed(Duration duration, [FutureOr<T> computation()]): создает объект Future, который запускается после временной задержки, указанной через первый параметр Duration. Второй необязательный параметр указывает на функцию, которая запускается после этой задержки.
// Future.error(Object error, [StackTrace stackTrace]): создает объект Future, который содержит информацию о возникшей ошибке.
// Future.microtask(FutureOr<T> computation()): создает объект Future, который с помощью функции scheduleMicrotask запускает функцию computation асинхронно и возвращает ее результат.
// Future.sync(FutureOr<T> computation()): создает объект Future, который содержит результат немедленно вызываемой функции computation.
// Future.value([FutureOr<T> value]): создает объект Future, который содержит значение value.

  /// Удаление задачи
  void onDelete(String id) {
    final curTasks = List<Task>.from(
      tasksState.value ?? []);
    final task = curTasks.firstWhere((t) => t.id == id).toString();
    curTasks.removeWhere((t) => t.id == id);
    tasksState.accept(curTasks);
    updateTaskSummary(curTasks);
    model.saveTasks(curTasks);
    
    log('Задача удалена: $task');

  }

  void showDeleteConfirmationDialog(String id) {
    showDialog<bool>(
      context: context,
      builder: (context) { 
        return AlertDialog(
        title: const Text('Удалить задачу'),
        content: const Text('Вы уверены, что хотите удалить эту задачу?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
      }
    ).then((confirmed) {
    if (confirmed == true) {
      onDelete(id);
      }
    });
  }

// Описание действия
// F5 Продолжить: Возобновить нормальное выполнение программы/скрипта (до следующей точки останова).
// Пауза: Проверить код, выполняемый в текущей строке, и отладить его построчно.
// Шаг с проходом
// F10 Выполнить следующий метод как одну команду без проверки и выполнения его составных шагов.
// Шаг с входом
// F11 Перейти к следующему методу для построчного отслеживания его выполнения.
// Шаг с выходом
// Shift+F11 Находясь внутри метода или подпрограммы, вернуться к предыдущему контексту выполнения, завершив оставшиеся строки текущего метода, как если бы это была одна команда.
// Перезапустить
// Ctrl+Shift+F5 Завершить выполнение текущей программы и начать отладку заново с использованием текущей конфигурации выполнения.
// Стоп
// Shift+F5 Завершить выполнение текущей программы.
// Set breakpoints in your code.
// Точка breakpoint — это маркер, который можно установить на строке кода, чтобы
// отладчик остановил выполнение кода при достижении этой строки. Вы

  bool _isPicking = false;

  Future<DateTime?> _selectDate(TextEditingController controller) async {
    if (_isPicking) return null;
    _isPicking = true;
    
    try {
      final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text = "${picked.day}.0${picked.month}.${picked.year}";
    }
    return picked;
  } finally {
    _isPicking = false;
    }
  }

  /// Показ диалога добавления новой задачи
  void showAddTaskDialog() {
    showDialog<Map<String, dynamic>>(
  context: context,
  builder: (context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final deadlineController = TextEditingController();
    DateTime? selectedDeadline;

    return AlertDialog(
      title: const Text('Добавить задачу'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Заголовок'),
          ),
          TextField(
            controller: descController,
            decoration: const InputDecoration(labelText: 'Описание'),
          ),
          TextField(
            controller: deadlineController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: "Дедлайн",
              suffixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              final picked = await _selectDate(deadlineController);
              if (picked != null) {
                selectedDeadline = picked;
              }
            } 
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            final title = titleController.text.trim();
            final desc = descController.text.trim();
            if (title.isNotEmpty && desc.isNotEmpty) {
              Navigator.pop(context, {
                'title': title, 'desc': desc, 'deadline' : selectedDeadline,
            });
            } else {
              Navigator.pop(context);
            }
          },
          child: const Text('Добавить'),
        ),
      ],
    );
  },
    ).then((result) {
      if (result != null) {
        final deadline = result['deadline'] ?? DateTime.now();
        final now = DateTime.now();
        int daysLeft = deadline.difference(now).inDays +1;
        onAdd(result['title']!, result['desc']!, deadline);
        scheduleReminder(id: 1, title: 'Задание ${result['title']} создано!', body: 'Осталось $daysLeft дней');
      }
    });
  }

//Переход на страницу задачи
  void showTaskInfo(String id) async {
    final task = tasksState.value?.firstWhere((t) => t.id == id);
    if (task == null) return;
    await context.pushRoute(TaskInfoRoute(task: task));
  }
  
  
  void scheduleReminder({required int id, required String title, required String body}) {
    final now = TZDateTime.now(local);
    final scheduledDate = now.add(const Duration(seconds: 3),);

    _notificationRepository.scheduleNotification(
      id: id, title: title, body: body, scheduledDate: scheduledDate,
    );
  }
}

TaskScreenWM createTaskScreenWM(BuildContext context) {
  final taskRepository = TaskRepository();

  return TaskScreenWM(TaskModel(TaskInteractor(TaskRepository())), taskRepository, getIt<NotificationRepository>(),);
}
