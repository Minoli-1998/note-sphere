import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/pages/create_new_note.dart';
import 'package:note_sphere/pages/home_page.dart';
import 'package:note_sphere/pages/notes_by_category.dart';
import 'package:note_sphere/pages/notes_page.dart';
import 'package:note_sphere/pages/single_note_page.dart';
import 'package:note_sphere/pages/tasks_page.dart';
import 'package:note_sphere/pages/update_note_page.dart';

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

      // new note page
      GoRoute(
        name: "create note",
        path: '/create-note',
        builder: (context, state) {
          final bool isNewCategory = state.extra as bool;
          return CreateNewNote(isNewCategory: isNewCategory);
        },
      ),

      // edit note page
      GoRoute(
        name: "edit note",
        path: '/edit-note',
        builder: (context, state) {
          final Note note = state.extra as Note;
          return UpdateNotePage(note: note);
        },
      ),

      // single note page
      GoRoute(
        name: "single note",
        path: '/single-note',
        builder: (context, state) {
          final Note note = state.extra as Note;
          return SingleNotePage(note: note);
        },
      ),
    ],
  );
}
