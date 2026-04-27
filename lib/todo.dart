import 'dart:convert';

class Todo {
  String id;
  String todoText;
  bool isDone;
  String? taskTime;

  Todo({
  required this.id,
  required this.todoText,
  this.isDone = false,
  this.taskTime,
});

  // 🔥 Convert Todo → Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoText': todoText,
      'isDone': isDone,
      'taskTime': taskTime,
    };
  }

  // 🔥 Convert Map → Todo
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      todoText: json['todoText'],
      isDone: json['isDone'],
      taskTime: json['taskTime'],
    );
  }
}