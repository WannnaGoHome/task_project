import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final void Function(Task) onToggle;
  final void Function(Task) onDelete;
  final void Function(Task) onTap;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: task.isCompleted ? Colors.pink[100] : Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side:BorderSide(
          color: task.isCompleted ? Colors.pinkAccent : Colors.pink.shade200,
          width: 1.2.w,
        ),
      ),
      child:  ListTile(
        key: ValueKey(task.isCompleted),
        onTap: () => onTap(task),
        leading: Checkbox(
          activeColor: Colors.pinkAccent,
          value: task.isCompleted,
          onChanged: (_) => onToggle(task),
          
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration:
            task.isCompleted ? TextDecoration.lineThrough : null,
          color: task.isCompleted ? Colors.black54 : Colors.black87,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        color: Colors.pinkAccent,
        onPressed: () => onDelete(task),
      ),
    ),
    );
  }
}
