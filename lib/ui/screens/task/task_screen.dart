import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:practise/domain/entities/task.dart';
import 'task_screen_wm.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class TaskScreen extends ElementaryWidget<TaskScreenWM> {
  final bool showCompleted;

  const TaskScreen({
    super.key,
    this.showCompleted = false,
  }) : super(createTaskScreenWM);

@override
Widget build(TaskScreenWM wm) {
  return Scaffold(
    appBar: AppBar(
      title: StateNotifierBuilder<Map<String, int>>(
        listenableState: wm.taskCounts,
        builder: (_, counts) {
          return Text(
            showCompleted
                ? 'Завершённые задачи (${counts?['completed'] ?? 0})'
                : 'Активные задачи (${counts?['active'] ?? 0})',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          );
        },
      ),
      backgroundColor: Colors.pinkAccent,
    ),
    body: StateNotifierBuilder<bool>(
      
      listenableState: wm.isLoading,
      builder: (_, loading) {
        if (loading ?? false) {
          return const Center(child: CircularProgressIndicator());
        }

        return StateNotifierBuilder<List<Task>>(
          listenableState: wm.tasksState,
          builder: (_, allTasks) {
            final tasks = (allTasks ?? [])
                .where((t) => t.isCompleted == showCompleted)
                .toList();

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: tasks.length,
              separatorBuilder: (_, __) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: DottedLine(
                  dashColor: Colors.pinkAccent,
                  lineThickness: 1.5,
                ),
              ),
              itemBuilder: (_, i) {
                final task = tasks[i];
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: Colors.pink[50],
                  title: Text(
                    task.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) => wm.onToggle(task.id),
                    activeColor: Colors.pink,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed:  () => wm.showDeleteConfirmationDialog(task.id),
                    color: Colors.pink[300],
                  ),
                  onTap: () => 
                    wm.showTaskInfo(task.id),
                );
              },
            );
          },
        );
      },
    ),
    floatingActionButton: !showCompleted
        ? FloatingActionButton(
            backgroundColor: Colors.pinkAccent,
            onPressed: wm.showAddTaskDialog,
            child: const Icon(Icons.add),
          )
        : const SizedBox.shrink(),
  );
}


}

