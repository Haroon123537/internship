import 'package:flutter/material.dart';
import 'todo.dart';
import 'shared_preferences_help.dart';

class TaskProvider extends ChangeNotifier {

  SharedPreferenecesHelp helper =
      SharedPreferenecesHelp();

  List<Todo> todos = [];

  
  Future<void> loadTodos() async {

    final data = await helper.loadTodos();

    todos.clear();

    todos.addAll(data);

    notifyListeners();
  }

  
  Future<void> addTask(
    String text,
    String time,
  ) async {

    if (text.isEmpty) return;

    todos.add(

      Todo(
        id: DateTime.now().toString(),
        todoText: text,
        taskTime: time,
      ),
    );

    await helper.saveTodos(todos);

    notifyListeners();
  }

  
  Future<void> deleteTask(
    String id,
  ) async {

    todos.removeWhere(
      (item) => item.id == id,
    );

    await helper.saveTodos(todos);

    notifyListeners();
  }

  
  Future<void> toggleDone(
    Todo todo,
  ) async {

    todo.isDone = !todo.isDone;

    await helper.saveTodos(todos);

    notifyListeners();
  }
}