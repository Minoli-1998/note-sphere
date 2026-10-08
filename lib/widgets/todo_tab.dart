import 'package:flutter/material.dart';
import 'package:note_sphere/models/task_model.dart';
import 'package:note_sphere/widgets/task_card.dart';

class TodoTab extends StatefulWidget {
  final List<Task> incompletedTasks;

  const TodoTab({super.key, required this.incompletedTasks});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
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

                return TaskCard(
                  isCompleted: false,
                  incompletedTask: incomepleted,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
