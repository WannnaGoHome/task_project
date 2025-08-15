import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:practise/data/repositories/secure_storage_repository.dart';
import 'package:practise/data/repositories/task_repository.dart';
import 'package:practise/domain/entities/user.dart';
import 'package:practise/interactors/task_interactor.dart';
import 'profile_model.dart';
import 'profile_screen.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:practise/data/repositories/user_repository.dart';
import 'package:practise/interactors/user_interactor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreenWM extends WidgetModel<ProfileScreen, UserModel> {
  
  final userState = StateNotifier<User?>();
  int taskCount = 0;

  ProfileScreenWM(super.model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _loadUserData();
    initScreen();
  }

  initScreen() async{
    loadUser();
    final TaskInteractor interactor = TaskInteractor(TaskRepository());
    var tasks = await interactor.load();
    taskCount = tasks.length;
  }

Future<void> loadUser() async {
    final user = await _loadUserData();
    userState.accept(user);
  }

  Future<User> _loadUserData() async {
  try {
    final users = await model.loadUsers();
    final user = users.firstWhere(
      (u) => u.isCurrent,
      orElse: () => User(
        id: '001',
        firstName: 'Иван',
        lastName: 'Дорн',
        isCurrent: true,
      ),
    );
    //userState.accept(user);
    return user;
  } catch (e) {
    rethrow;
  }
}

  Future<void> clearSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

Future<void> clearSecuredSharedPreferences() async {
  final secureStorage = SecureStorageRepository();
  await secureStorage.deleteAllValue();
}


  @override
  void dispose() {
    super.dispose();
  }
}

ProfileScreenWM createProfileScreenWM(BuildContext context) {
  return ProfileScreenWM(UserModel(UserInteractor(UserRepository())), );
}
