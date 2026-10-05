import 'package:flutter/material.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/theme_data.dart';

void main() {
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
