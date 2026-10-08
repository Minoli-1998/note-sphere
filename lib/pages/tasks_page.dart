import 'package:flutter/material.dart';
import 'package:note_sphere/models/task_model.dart';
import 'package:note_sphere/services/todo_service.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_styles.dart';
import 'package:note_sphere/widgets/completed_tab.dart';
import 'package:note_sphere/widgets/todo_tab.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // tasks list variables
  late List<Task> allTasks = [];
  late List<Task> incompletedTasks = [];
  late List<Task> completedTasks = [];

  // initialize todo service
  final TodoService todoService = TodoService();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _checkIfUserNew();
    super.initState();
  }

  // check whether the user is new
  void _checkIfUserNew() async {
    final bool isNewUser = await todoService.isNewUser();

    // if user is new create initial tasks
    if (isNewUser) {
      await todoService.createInitialTasks();
    }

    _loadAllTasks();
  }

  // load all tasks
  Future<void> _loadAllTasks() async {
    final List<Task> loadedTasks = await todoService.loadAllTasks();
    setState(() {
      allTasks = loadedTasks;

      // incomepleted tasks
      incompletedTasks = allTasks.where((element) => !element.isDone).toList();

      // completed tasks
      completedTasks = allTasks.where((element) => element.isDone).toList();
    });
  }

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
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                "To-Do",
                style: AppTextStyles.appDescriptionLargeStyle,
              ),
            ),

            Tab(
              child: Text(
                "Completed",
                style: AppTextStyles.appDescriptionLargeStyle,
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 1)),
        child: Icon(Icons.add, color: AppColors.kWhiteColor, size: 30),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          TodoTab(incompletedTasks: incompletedTasks),
          CompletedTab(completedTasks: completedTasks),
        ],
      ),
    );
  }
}
