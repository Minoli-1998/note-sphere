import 'package:flutter/material.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/task_model.dart';
import 'package:note_sphere/services/todo_service.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/widgets/task_card.dart';

class TodoTab extends StatefulWidget {
  final List<Task> incompletedTasks;
  final List<Task> completedTasks;

  const TodoTab({
    super.key,
    required this.incompletedTasks,
    required this.completedTasks,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  // initialize todo service
  final TodoService todoService = TodoService();

  // updating incompleted task as completed
  Future<void> _markIncompletedTaskAsDone(Task inCompletedask) async {
    try {
      final Task updatedTask = Task(
        title: inCompletedask.title,
        date: inCompletedask.date,
        time: inCompletedask.time,
        isDone: true,
      );

      await todoService.markAsDone(updatedTask);

      // displaying a message
      if (context.mounted) {
        AppHelpers.showSnackBarMessage(context, "Marked as done");
      }

      // remove from incompleted list
      setState(() {
        widget.incompletedTasks.remove(inCompletedask);
        widget.completedTasks.add(updatedTask);
      });

      // navigate to saame page to refresh the page
      AppRouter.router.go("/tasks");
    } catch (error) {
      if (context.mounted) {
        AppHelpers.showSnackBarMessage(context, "Failed to mark as done");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.incompletedTasks.sort((a, b) => a.time.compareTo(b.time));
    });

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: 20),

          // listview of incompleted tasks
          Expanded(
            child: ListView.builder(
              itemCount: widget.incompletedTasks.length,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Task incomepleted = widget.incompletedTasks[index];

                return Dismissible(
                  key: ValueKey(incomepleted.id.toString()),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    setState(() {
                      widget.incompletedTasks.removeAt(index);
                      todoService.deleteTask(incomepleted);
                    });

                    AppHelpers.showSnackBarMessage(context, "Task deleted");
                  },
                  child: TaskCard(
                    isCompleted: false,
                    incompletedTask: incomepleted,
                    onCheckBoxChanged: () =>
                        _markIncompletedTaskAsDone(incomepleted),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
