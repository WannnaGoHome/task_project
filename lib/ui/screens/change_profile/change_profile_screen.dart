
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practise/ui/screens/change_profile/change_profile_screen_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:practise/domain/entities/user.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ChangeProfileScreen extends ElementaryWidget<ChangeProfileScreenWm> {
  const ChangeProfileScreen({
    super.key,
    @PathParam() this.userId,
  }) : super(createChangeProfileScreenWm);
  
  final String? userId; 

  @override
  Widget build(ChangeProfileScreenWm wm) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        centerTitle: false,
        elevation: 0, 
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        title: Text(
          "Изменить профиль",
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
                      _buildInfoRow("ID пользователя", 'userId', wm.controllers['id']!),
                      const Divider(color: Colors.pink),
                      _buildInfoRow("Имя", 'firstName', wm.controllers['firstName']!),
                      const Divider(color: Colors.pink),
                      _buildInfoRow("Фамилия", 'lastName', wm.controllers['lastName']!),
                      const Divider(color: Colors.pink),
                      _buildInfoRow("Всего задач", wm.taskCount.toString(), TextEditingController(text: wm.taskCount.toString()), editable: false),
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
                      final isSaved = await wm.saveProfileInfo();
                      if (isSaved && context.mounted) {
                          context.router.maybePop(true);
                        }
                      },
                    child: Text(
                      "Сохранить",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
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

  Widget _buildInfoRow(String title, String key, TextEditingController controller, {bool editable = true}) {
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
        Flexible(
          child: editable
              ? TextField(
                  controller: controller,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[600],
                  ),
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration.collapsed(hintText: ''),
                )
              : Text(
                  controller.text,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[600],
                  ),
                  textAlign: TextAlign.right,
                ),
        ),
      ],
    ),
  );
}

}