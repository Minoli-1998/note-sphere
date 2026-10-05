import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/pages/home_page.dart';
import 'package:note_sphere/pages/notes_page.dart';
import 'package:note_sphere/pages/tasks_page.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    initialLocation: "/",
    routes: [
      // home page
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) {
          return HomePage();
        },
      ),

      // tasks page
      GoRoute(
        name: "tasks",
        path: '/tasks',
        builder: (context, state) {
          return TasksPage();
        },
      ),

      // notes page
      GoRoute(
        name: "notes",
        path: '/notes',
        builder: (context, state) {
          return NotesPage();
        },
      ),
    ],
  );
}
