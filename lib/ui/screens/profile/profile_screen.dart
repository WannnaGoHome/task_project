//Профиль пользователя сделать счётчик 
//( имя фамилия общее количество заданий) и детальная страница (данные по таску)
// Страница редактирования профиля

// then почитать
// Метод then() привязывается к Future и ожидает его завершения.
// Он принимает функцию обратного вызова, которая будет выполнена, когда Future завершится.

// убрать TaskService

// закрытие диалога

// красивый вывод даты

// ** разные уровни навигации Детальная страница - внутри, профиль - поверх тасков

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:practise/data/router/task_router.dart';
import 'profile_screen_wm.dart';
import 'package:practise/domain/entities/user.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ProfileScreen extends ElementaryWidget<ProfileScreenWM> {
  const ProfileScreen({super.key}) : super(createProfileScreenWM);

  @override
  Widget build(ProfileScreenWM wm) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        title: Text(
          "Профиль",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: StateNotifierBuilder<User?>(
          listenableState: wm.userState,
          builder: (context, user) {
            if (user == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.pinkAccent,
                      width: 3.w,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      "https://i.postimg.cc/cCsYDjvj/user.png",
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: GoogleFonts.montserrat(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800],
                  ),
                ),
                const SizedBox(height: 32),
                _buildInfoCard(
                  child: Column(
                    children: [
                      _buildInfoRow("ID пользователя", user.id),
                      const Divider(color: Colors.pink),
                      _buildInfoRow("Имя", user.firstName),
                      const Divider(color: Colors.pink),
                      _buildInfoRow("Фамилия", user.lastName),
                      const Divider(color: Colors.pink),
                      _buildInfoRow("Всего задач", wm.taskCount.toString()),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      context.pushRoute<bool>(ChangeProfileRoute()).
                      then((result) {
                        if (result == true) {
                          wm.loadUser();
                        }
                      });
                    },
                    child: Text(
                      "Редактировать профиль",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      context.pushRoute(const AuthorizationRoute());
                      wm.clearSharedPreferences();
                      wm.clearSecuredSharedPreferences();
                    }, 
                    child: const Text('Выйти из аккаунта')),)
              ],
            );
          },
        ),
      ),
    );
  
  }

  Widget _buildInfoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.pink.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: Colors.pink[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              color: Colors.pink[600],
            ),
          ),
        ],
      ),
    );
  }

}