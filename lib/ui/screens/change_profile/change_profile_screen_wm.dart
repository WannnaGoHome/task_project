import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:practise/data/repositories/task_repository.dart';
import 'package:practise/data/repositories/user_repository.dart';
import 'package:practise/domain/entities/user.dart';
import 'package:practise/interactors/task_interactor.dart';
import 'package:practise/interactors/user_interactor.dart';
import 'package:practise/ui/screens/profile/profile_model.dart';
import 'package:practise/ui/screens/change_profile/change_profile_screen.dart';

class ChangeProfileScreenWm extends WidgetModel<ChangeProfileScreen, UserModel> {
  final taskCounts = StateNotifier<Map<String, int>>(initValue: {'active': 0, 'completed': 0});
  final userState = StateNotifier<User?>();
  final Map<String, TextEditingController> controllers = {};
  final String? userId;
 
  int taskCount = 0;

  ChangeProfileScreenWm(
    super.model, {
    required this.userId,
  });

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    initScreen();
  }

  initScreen() async {
    await loadUser();
    final TaskInteractor interactor = TaskInteractor(TaskRepository());
    var tasks = await interactor.load();
    taskCount = tasks.length;
  }

  void initializeControllers(User user) {
    controllers['id'] = TextEditingController(text: user.id);
    controllers['firstName'] = TextEditingController(text: user.firstName);
    controllers['lastName'] = TextEditingController(text: user.lastName);
  }

  Future<void> loadUser() async {
    final user = await getUser();
    userState.accept(user);
    initializeControllers(user);
  }

  Future<User> getUser() async {
    try {
      final users = await model.loadUsers();
      // Если передан userId, ищем по нему, иначе ищем текущего пользователя
      if (userId != null) {
        return users.firstWhere(
          (u) => u.id == userId,
          orElse: () => User(
            id: userId!,
            firstName: 'Новый',
            lastName: 'Пользователь',
            isCurrent: true,
          ),
        );
      }
      return users.firstWhere(
        (u) => u.isCurrent,
        orElse: () => User(
          id: '001',
          firstName: 'Иван',
          lastName: 'Дорн',
          isCurrent: true,
        ),
      );
    } catch (e) {
      return User(
        id: userId ?? '001',
        firstName: 'Ошибка',
        lastName: 'Загрузки',
        isCurrent: true,
      );
    }
  }

  Future<bool> saveProfileInfo() async {
    final currentUser = userState.value;
    if (currentUser != null) 
    {
      final updatedUser = User(
      id: controllers['id']?.text ?? currentUser.id,
      firstName: controllers['firstName']?.text ?? currentUser.firstName,
      lastName: controllers['lastName']?.text ?? currentUser.lastName,
      isCurrent: true,
    );
    final updatedUsers = await model.loadUsers();
    final index = updatedUsers.indexWhere((u) => userId != null ? u.id == userId : u.isCurrent);
    if (index != -1) {
      updatedUsers[index] = updatedUser;
    } else {
      updatedUsers.add(updatedUser);
    }
    await model.save(updatedUsers);
    userState.accept(updatedUser);
    return true;
    }
    else {
      return false;
    }
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}


ChangeProfileScreenWm createChangeProfileScreenWm(BuildContext context, {String? userId}) {
  return ChangeProfileScreenWm(
    UserModel(UserInteractor(UserRepository())),
    userId: userId,
  );
}

