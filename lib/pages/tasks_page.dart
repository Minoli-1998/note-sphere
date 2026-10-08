import 'package:flutter/material.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/task_model.dart';
import 'package:note_sphere/services/todo_service.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_styles.dart';
import 'package:note_sphere/widgets/completed_tab.dart';
import 'package:note_sphere/widgets/task_inherited_widget.dart';
import 'package:note_sphere/widgets/todo_tab.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // controller for text field
  final TextEditingController _taskController = TextEditingController();

  // dispose controllers
  @override
  void dispose() {
    _tabController.dispose();
    _taskController.dispose();
    super.dispose();
  }

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

  // add task
  Future<void> _addTask() async {
    try {
      if (_taskController.text.trim().isEmpty) {
        return;
      }

      final Task newTask = Task(
        title: _taskController.text.trim(),
        date: DateTime.now(),
        time: DateTime.now(),
        isDone: false,
      );

      // Save task to Hive
      await todoService.addTask(newTask);

      // Reload tasks from Hive
      await _loadAllTasks();

      // Clear text field
      _taskController.clear();

      // Close dialog first
      if (context.mounted) {
        Navigator.pop(context);

        AppHelpers.showSnackBarMessage(context, "New task added successfully");
      }
    } catch (error) {
      if (context.mounted) {
        AppHelpers.showSnackBarMessage(context, "Failed to add new task");
      }
    }
  }

  // open dialog box
  void openMessageModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: AppColors.kCardColor,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Add Tasks",
              style: AppTextStyles.appDescriptionLargeStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _taskController,
              style: TextStyle(fontSize: 20, color: AppColors.kWhiteColor),
              decoration: InputDecoration(
                hintText: "Enter your Task",
                hintStyle: AppTextStyles.appDescriptionSmallStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            // add task button
            ElevatedButton(
              onPressed: () {
                _addTask();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.kFabColor),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(100),
                  ),
                ),
              ),
              child: Text("Add Task", style: AppTextStyles.appButton),
            ),

            // cancel button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.kFabColor),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(100),
                  ),
                ),
              ),
              child: Text("Cancel", style: AppTextStyles.appButton),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TaskData(
      tasks: allTasks,
      onTaskChanged: () => _loadAllTasks(),
      child: Scaffold(
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
          onPressed: () {
            openMessageModal(context);
          },
          shape: CircleBorder(side: BorderSide(color: Colors.white, width: 1)),
          child: Icon(Icons.add, color: AppColors.kWhiteColor, size: 30),
        ),

        body: TabBarView(
          controller: _tabController,
          children: [
            TodoTab(
              incompletedTasks: incompletedTasks,
              completedTasks: completedTasks,
            ),
            CompletedTab(
              completedTasks: completedTasks,
              inCompletedTasks: incompletedTasks,
            ),
          ],
        ),
      ),
    );
  }
}
