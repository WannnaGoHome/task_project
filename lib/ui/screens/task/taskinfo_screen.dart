import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../domain/entities/task.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class TaskInfoScreen extends StatelessWidget {
  final Task task;

  const TaskInfoScreen({ super.key, required this.task,});

  @override
  Widget build(BuildContext context) {
    final title = task.title;
    final description = task.description;
    final status = task.isCompleted ? 'Завершён' : 'Активен';

    String formatTaskDate(String taskId) {
      final date = DateTime.tryParse(taskId)?.toLocal();
      if (date != null) {
        return DateFormat('MMMM d, yyyy').format(date);
      }
      return taskId;
    }

    final date = formatTaskDate(task.id);

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text('Информация о задаче'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          width: 300.w,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.pink.shade100.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'lib/ui/assets/dance_stars.gif',
                    height: 150.h,
                    width: 250.w,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time, size: 18, color: Colors.orange),
                    SizedBox(width: 6.w),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.task_alt_rounded, size: 18, color: Colors.green),
                    SizedBox(width: 6.w),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
