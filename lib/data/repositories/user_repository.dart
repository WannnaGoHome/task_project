import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practise/domain/entities/user.dart';

class UserRepository {
  static const _key = 'users';

  static final List<User> _userList = [
    User(
      id: '001',
      firstName: 'Иван',
      lastName: 'Дорн',
      isCurrent: true,
    ),
    User(
      id: '002',
      firstName: 'Тина',
      lastName: 'Кароль',
      isCurrent: false,
    ),
    User(
      id: '003',
      firstName: 'Хихихи',
      lastName: 'Хахаха',
      isCurrent: false,
    ),
  ];

  /// Сохраняем список в shared_preferences
  Future<void> initializeUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_key);
    if (existing == null) {
      final encoded = jsonEncode(_userList.map((u) => u.toJson()).toList());
      await prefs.setString(_key, encoded);
    }
  }

  /// Загружаем пользователей из shared_preferences
  Future<List<User>> loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json != null) {
      final List<dynamic> decoded = jsonDecode(json);
      return decoded.map((e) => User.fromJson(e)).toList();
    }
    return [];
  }

  /// Сохраняем список пользователей
  Future<void> saveUsers(List<User> users) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(users.map((u) => u.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  
}
