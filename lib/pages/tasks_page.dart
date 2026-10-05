import 'package:flutter/material.dart';
import 'package:note_sphere/utils/router.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            // navigate to home page
            AppRouter.router.go("/");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
