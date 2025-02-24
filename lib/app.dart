import 'package:flutter/material.dart';
import 'features/timer/timer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerPage(),
    );
  }
}