
import 'package:flutter/material.dart';
import 'package:internship/todo_provider.dart';
import 'package:provider/provider.dart';
//import 'todo.dart';
//import 'shared_preferences_help.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class TodoListApp extends StatefulWidget {
  const TodoListApp({super.key});

  @override
  State<TodoListApp> createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp> {

  //SharedPreferenecesHelp _preferenecesHelper= SharedPreferenecesHelp();

  //final List<Todo> todos = [];
  final TextEditingController _controller = TextEditingController();
  //final provider =Provider.of<TodoProvider>(context);

  @override
void initState() {
  super.initState();
  Future.microtask(() {
  Provider.of<TodoProvider>(
    context,
    listen: false,
  ).loadTodos();
});
 // _loadTodos();
}



  @override
  Widget build(BuildContext context) {
    final provider =
      Provider.of<TodoProvider>(context);
    
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
                  onPressed: () {

  provider.addTask(
    _controller.text,
  );

  _controller.clear();
},
                  child: const Text("Add"),
                )
              ],
            ),
          ),

          // 🔹 List of Tasks
          Expanded(
            child: ListView.builder(
              itemCount: provider.todos.length,
              itemBuilder: (context, index) {
                final todo = provider.todos[index];

                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 5),
                  child: ListTile(
                    tileColor: Colors.white,

                    
                    leading: IconButton(
                      icon: Icon(
                        todo.isDone
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Colors.blue,
                      ),
                      onPressed: () => provider.toggleDone(todo)
                    ),

                   
                    title: Text(
                      todo.todoText,
                      style: TextStyle(
                        decoration: todo.isDone
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),

                    
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => provider.deleteTask(todo.id)
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