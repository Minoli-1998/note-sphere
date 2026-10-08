import 'package:flutter/material.dart';
import 'package:note_sphere/models/task_model.dart';

class TaskData extends InheritedWidget {
  final List<Task> tasks;
  final Function() onTaskChanged;

  const TaskData({
    super.key,
    required super.child,
    required this.tasks,
    required this.onTaskChanged,
  });

  static TaskData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskData>();
  }

  @override
  bool updateShouldNotify(covariant TaskData oldWidget) {
    return tasks != oldWidget.tasks;
  }
}
