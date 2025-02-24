import 'package:flutter/material.dart';
import 'features/timer/timer.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:pointsapp/features/todos/home/home.dart';

class App extends StatelessWidget {
  const App({super.key, required TodosRepository todoRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: TimerPage(),
      home: HomePage(),
    );
  }
}
