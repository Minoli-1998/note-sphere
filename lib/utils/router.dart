import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/pages/home_page.dart';
import 'package:note_sphere/pages/notes_by_category.dart';
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

      // notes by category
      GoRoute(
        name: "category",
        path: '/category',
        builder: (context, state) {
          final String category = state.extra as String;
          return NotesByCategory(category: category);
        },
      ),
    ],
  );
}
