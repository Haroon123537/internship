import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo.dart';

class SharedPreferenecesHelp{

  // 🔥 SAVE TODOS
  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> todoList =
        todos.map((todo) => jsonEncode(todo.toJson())).toList();

    await prefs.setStringList('todos', todoList);
  }

  // 🔥 LOAD TODOS
  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? data = prefs.getStringList('todos');

    if (data == null) return [];

    return data
        .map((item) => Todo.fromJson(jsonDecode(item)))
        .toList();
  }
}