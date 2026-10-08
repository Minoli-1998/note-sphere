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
}
