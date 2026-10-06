import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/models/task_model.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/theme_data.dart';

void main() async {
  // initialize Hive
  await Hive.initFlutter();

  // register the adapters
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TaskAdapter());

  // open hive boxes
  await Hive.openBox('notes');
  await Hive.openBox('tasks');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "NoteSphere",
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
