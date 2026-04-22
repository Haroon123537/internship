import 'package:flutter/material.dart';
import 'todo.dart';
import 'shared_preferences_help.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListApp extends StatefulWidget {
  const TodoListApp({super.key});

  @override
  State<TodoListApp> createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp> {

  SharedPreferenecesHelp _preferenecesHelper= SharedPreferenecesHelp();

  final List<Todo> todos = [];
  final TextEditingController _controller = TextEditingController();

  @override
void initState() {
  super.initState();
  _loadTodos();
}

void _loadTodos() async {
  final data = await _preferenecesHelper.loadTodos();

  setState(() {
    todos.clear();
    todos.addAll(data);
  });
}

  // ✅ Add Task
 void _addTask() async {
  if (_controller.text.isEmpty) return;

  setState(() {
    todos.add(
      Todo(
        id: DateTime.now().toString(),
        todoText: _controller.text,
      ),
    );
  });

  await _preferenecesHelper.saveTodos(todos); // 🔥 SAVE
  _controller.clear();
}

  // ✅ Delete Task
  void _deleteTask(String id) async {
  setState(() {
    todos.removeWhere((item) => item.id == id);
  });

  await _preferenecesHelper.saveTodos(todos); // 🔥 SAVE
}

  // ✅ Toggle Complete
  void _toggleDone(Todo todo) async {
  setState(() {
    todo.isDone = !todo.isDone;
  });

  await _preferenecesHelper.saveTodos(todos); // 🔥 SAVE
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        title: const Text('Todo App'),
        backgroundColor: Colors.purple,
      ),

      body: Column(
        children: [

          // 🔹 Input Field
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Add a new task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: const Text("Add"),
                )
              ],
            ),
          ),

          // 🔹 List of Tasks
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 5),
                  child: ListTile(
                    tileColor: Colors.white,

                    // ✅ Mark complete
                    leading: IconButton(
                      icon: Icon(
                        todo.isDone
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Colors.blue,
                      ),
                      onPressed: () => _toggleDone(todo),
                    ),

                    // ✅ Text
                    title: Text(
                      todo.todoText,
                      style: TextStyle(
                        decoration: todo.isDone
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),

                    // ✅ Delete
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteTask(todo.id),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}