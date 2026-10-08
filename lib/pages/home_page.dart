import 'package:flutter/material.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/models/task_model.dart';
import 'package:note_sphere/services/note_service.dart';
import 'package:note_sphere/services/todo_service.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_styles.dart';
import 'package:note_sphere/widgets/home_page_task_card.dart';
import 'package:note_sphere/widgets/notes_todo_card.dart';
import 'package:note_sphere/widgets/progress_card.dart';
import 'package:note_sphere/widgets/task_inherited_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // initializing services
  final NoteService noteService = NoteService();
  final TodoService taskService = TodoService();

  // initializing allNotes and allTasks
  late List<Note> allNotes = [];
  late List<Task> allTasks = [];

  @override
  void initState() {
    super.initState();
    checkIfUserIsNew();
    setState(() {});
  }

  // creating initial notes and tasks
  void checkIfUserIsNew() async {
    final bool isNewUser =
        await noteService.isNewUser() || await taskService.isNewUser();

    if (isNewUser) {
      // create initial notes and tasks
      await noteService.createdInitialNotes();
      await taskService.createInitialTasks();
    }
    _loadNotes();
    _loadTasks();
  }

  // load all notes
  Future<void> _loadNotes() async {
    final List<Note> loadedNotes = await noteService.loadNotes();
    setState(() {
      allNotes = loadedNotes;
    });
  }

  // load all tasks
  Future<void> _loadTasks() async {
    final List<Task> loadedTasks = await taskService.loadAllTasks();
    setState(() {
      allTasks = loadedTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TaskData(
      tasks: allTasks,
      onTaskChanged: () => _loadTasks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("NoteSphere", style: AppTextStyles.appTitle),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Column(
              children: [
                SizedBox(height: AppConstants.kDefaultPadding),

                ProgressCard(
                  numberOfCompletedTasks: allTasks
                      .where((element) => element.isDone)
                      .length,
                  numberOfTotalTasks: allTasks.length,
                ),

                SizedBox(height: AppConstants.kDefaultPadding),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AppRouter.router.push('/notes');
                      },
                      child: NotesTodoCard(
                        value: allNotes.length,
                        isNote: true,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        AppRouter.router.push('/tasks');
                      },
                      child: NotesTodoCard(
                        value: allTasks.length,
                        isNote: false,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppConstants.kDefaultPadding),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today's Progress", style: AppTextStyles.appSubTitle),

                    Text("See All", style: AppTextStyles.appButton),
                  ],
                ),

                SizedBox(height: AppConstants.kDefaultPadding),

                allTasks.isEmpty
                    ? Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                "No tasks for today, Add some tasks to get started!",
                                style: AppTextStyles.appDescriptionLargeStyle
                                    .copyWith(
                                      color: AppColors.kWhiteColor.withValues(
                                        alpha: 0.5,
                                      ),
                                      fontSize: 18,
                                    ),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: 20),

                              ElevatedButton(
                                onPressed: () {
                                  AppRouter.router.push('/tasks');
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.blue,
                                  ),
                                ),
                                child: Text(
                                  "Add Task",
                                  style: AppTextStyles.appButton.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    :
                      // To-Do list
                      ListView.builder(
                        itemCount: allTasks.length,
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Task task = allTasks[index];
                          return HomePageTaskCard(task: task);
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
