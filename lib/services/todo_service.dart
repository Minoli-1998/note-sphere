import 'package:hive/hive.dart';
import 'package:note_sphere/models/task_model.dart';

class TodoService {
  // all tasks
  List<Task> allTasks = [
    Task(
      title: "Read a Book",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    Task(
      title: "Go for a Walk",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    Task(
      title: "Complete Assignment",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
  ];

  // create the db reference for the tasks
  final _myBox = Hive.box('tasks');

  // check whether the user is new
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  // method to create initial tasks if the box is empty
  Future<void> createInitialTasks() async {
    if (_myBox.isEmpty) {
      await _myBox.put('tasks', allTasks);
    }
  }

  // method to load all notes
  Future<List<Task>> loadAllTasks() async {
    // get all tasks from box
    final dynamic allTasks = await _myBox.get('tasks');

    // if tasks list is not null and a list of dynamic type return list
    if (allTasks != null && allTasks is List<dynamic>) {
      return allTasks.cast<Task>().toList();
    }

    return [];
  }

  // mark as done
  Future<void> markAsDone(Task task) async {
    try {
      // get all tasks
      final List<dynamic> allTasks = await _myBox.get('tasks') ?? [];
      final List<Task> tasks = allTasks.cast<Task>().toList();

      // get the task id that has same id as passed parameter
      final int index = tasks.indexWhere((element) => element.id == task.id);
      tasks[index] = task;

      // save in box
      await _myBox.put('tasks', tasks);
    } catch (error) {
      error.toString();
    }
  }

  // add a task
  Future<void> addTask(Task task) async {
    try {
      // get all tasks
      final List<dynamic> allTasks = await _myBox.get('tasks') ?? [];
      final List<Task> tasks = allTasks.cast<Task>().toList();

      // add the task in the list
      tasks.add(task);

      // save in box
      _myBox.put("tasks", tasks);
    } catch (error) {
      error.toString();
    }
  }

  // delete a task
  Future<void> deleteTask(Task task) async {
    try {
      // get all tasks from the tasks
      final List<dynamic> allTasks = await _myBox.get('tasks') ?? [];
      final List<Task> tasks = allTasks.cast<Task>().toList();

      // remove from the list
      tasks.remove(task);

      // save updated list in box
      await _myBox.put('tasks', tasks);
    } catch (error) {
      error.toString();
    }
  }
}
