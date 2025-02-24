import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pointsapp/simple_observer.dart';
import 'package:todos_api/todos_api.dart';
import 'app.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';
import 'package:todos_repository/todos_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final todosApi = LocalStorageTodosApi(
    plugin: await SharedPreferences.getInstance(),
  );

  final todosRepository = TodosRepository(todosApi: todosApi);

  runApp(App(todoRepository: todosRepository));
}
