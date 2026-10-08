import 'package:flutter/material.dart';
import 'package:note_sphere/models/task_model.dart';

class CompletedTab extends StatefulWidget {
  final List<Task> completedTasks;
  const CompletedTab({super.key, required this.completedTasks});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Completed", style: TextStyle(color: Colors.white)),
    );
  }
}
