import 'package:flutter/material.dart';
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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
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
        children: [TodoTab(), CompletedTab()],
      ),
    );
  }
}
