import 'package:flutter/material.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/task_model.dart';
import 'package:note_sphere/services/todo_service.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/widgets/task_card.dart';

class CompletedTab extends StatefulWidget {
  final List<Task> completedTasks;
  final List<Task> inCompletedTasks;

  const CompletedTab({
    super.key,
    required this.completedTasks,
    required this.inCompletedTasks,
  });

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  // initialize todo service
  final TodoService todoService = TodoService();

  // updating incompleted task as completed
  Future<void> _markCompletedTaskAsNotDone(Task completedTask) async {
    try {
      final Task updatedTask = Task(
        id: completedTask.id,
        title: completedTask.title,
        date: completedTask.date,
        time: completedTask.time,
        isDone: false,
      );

      await todoService.markAsDone(updatedTask);

      // displaying a message
      if (context.mounted) {
        AppHelpers.showSnackBarMessage(context, "Marked as not completed");
      }

      // remove from incompleted list
      setState(() {
        widget.completedTasks.remove(completedTask);
        widget.inCompletedTasks.add(updatedTask);
      });

      // navigate to saame page to refresh the page
      AppRouter.router.go("/tasks");
    } catch (error) {
      if (context.mounted) {
        AppHelpers.showSnackBarMessage(
          context,
          "Failed to mark as not completed",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.completedTasks.sort((a, b) => a.time.compareTo(b.time));
    });

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: Column(
        children: [
          SizedBox(height: 20),

          // listview of incompleted tasks
          Expanded(
            child: ListView.builder(
              itemCount: widget.completedTasks.length,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Task completedTask = widget.completedTasks[index];

                return Dismissible(
                  key: ValueKey(completedTask.id.toString()),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    setState(() {
                      widget.completedTasks.removeAt(index);
                      todoService.deleteTask(completedTask);
                    });

                    AppHelpers.showSnackBarMessage(context, "Task deleted");
                  },
                  child: TaskCard(
                    isCompleted: true,
                    incompletedTask: completedTask,
                    onCheckBoxChanged: () =>
                        _markCompletedTaskAsNotDone(completedTask),
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
