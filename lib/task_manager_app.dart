import 'package:flutter/material.dart';
import 'package:internship/shared_preferences_help.dart';
import 'home_page.dart';
import 'Login_page.dart';
import 'counter_page.dart';
import 'todo.dart';
import 'todo_list_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  SharedPreferenecesHelp _preferenecesHelper = SharedPreferenecesHelp();

  bool isHomeLoading = false;
  bool isLoginLoading = false;
  bool isCounterLoading = false;
  bool isAddingTask = false;
  String? deletingTaskId;
  String searchText = "";
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final List<Todo> todos = [];

  void _loadTodos() async {
    final data = await _preferenecesHelper.loadTodos();

    setState(() {
      todos.clear();
      todos.addAll(data);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _addTask() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      todos.add(
        Todo(
          id: DateTime.now().toString(),
          todoText: _controller.text,
          taskTime: _timeController.text,
        ),
      );
    });

    await _preferenecesHelper.saveTodos(todos); // 🔥 SAVE
    _controller.clear();
    _timeController.clear();
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
      appBar: AppBar(
        clipBehavior: Clip.antiAlias,
        title: Text('Task Management'),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 3.0,
          fontStyle: FontStyle.normal,
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 2.0,
        shadowColor: Colors.black45,
        actions: [
          IconButton(
            icon: isHomeLoading
                ? SizedBox(
                    width: 20,
                    height: 20,

                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(Icons.add_task, color: Colors.white),

            onPressed: () async {
              setState(() => isHomeLoading = true);

              await Future.delayed(Duration(seconds: 1));

              _addTask();

              setState(() => isHomeLoading = false);
            },
          ),
          SizedBox(width: 10),
          IconButton(
            icon: isLoginLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Icon((Icons.search), color: Colors.white),

            onPressed: () {
              showSearch(context: context, delegate: TaskSearchDelegate(todos));
            },
            hoverColor: Colors.white24,
            focusColor: Colors.black,
            splashColor: Colors.white54,
            splashRadius: 20,
          ),
          SizedBox(width: 10),
          IconButton(
            icon: isCounterLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(Icons.delete_sweep, color: Colors.white, size: 24),
            onPressed: () async {
              setState(() => isCounterLoading = true);

              await Future.delayed(Duration(seconds: 2));

              setState(() => isCounterLoading = false);

              showDialog(
                context: context,

                builder: (context) {
                  return AlertDialog(
                    title: Text("Select Task To Delete"),

                    content: Container(
                      width: double.maxFinite,

                      child: ListView.builder(
                        shrinkWrap: true,

                        itemCount: todos.length,

                        itemBuilder: (context, index) {
                          final todo = todos[index];

                          return ListTile(
                            title: Text(todo.todoText),

                            subtitle: Text(todo.taskTime ?? ""),

                            onTap: () {
                              _deleteTask(todo.id);

                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
            hoverColor: Colors.white24,
            focusColor: Colors.black,
            splashColor: Colors.white54,
            splashRadius: 20,
          ),
          SizedBox(width: 20),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.tealAccent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Task Manager App",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    title: Text("Counter"),
                    leading: Icon(Icons.countertops),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CounterPage()),
                      );
                    },
                    trailing: Icon(Icons.arrow_forward_ios),
                    selected: true,
                  ),
                  ListTile(
                    title: Text("Todo List"),
                    leading: Icon(Icons.list_alt),
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TodoListApp()),
                      );
                    },

                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    title: Text("Logout"),
                    textColor: Colors.white,
                    leading: Icon(Icons.logout),
                    iconColor: Colors.white,
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();

                      await prefs.setBool("isLoggedIn", false);

                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.tealAccent,

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(15),

              child: Column(
                children: [
                  // Task Field
                  Container(
                    width: 500,

                    child: TextField(
                      keyboardType: TextInputType.text,
                      showCursor: true,
                      textCapitalization: TextCapitalization.none,
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                        suffixIcon: Icon(Icons.task, color: Colors.blue),
                        hintText: "Add a new task",
                        hintStyle: TextStyle(color: Colors.black45),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Time Field
                  Container(
                    width: 500,

                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _timeController,
                      showCursor: true,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                        hintText: "Enter task time",

                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.access_time, color: Colors.blue),
                        hintStyle: TextStyle(color: Colors.black45),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Add Button
                  ElevatedButton(
                    onPressed: () async {
                      // Validation
                      if (_controller.text.isEmpty ||
                          _timeController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please enter both task title and time",
                            ),

                            backgroundColor: Colors.red,
                          ),
                        );

                        return;
                      }

                      setState(() {
                        isAddingTask = true;
                      });

                      await Future.delayed(Duration(seconds: 1));

                      _addTask();

                      setState(() {
                        isAddingTask = false;
                      });
                    },

                    child: isAddingTask
                        ? SizedBox(
                            width: 20,
                            height: 20,

                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text("Add"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return Center(
                  child: Container(
                    width: 1200,
                    //height: 50,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),

                    child: ListTile(
                      onTap: () => _toggleDone(todo),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      hoverColor: Colors.white24,

                      focusColor: Colors.black,
                      tileColor: Colors.white,
                      splashColor: Colors.white54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),

                      leading: IconButton(
                        icon: Icon(
                          todo.isDone
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: Colors.blue,
                        ),

                        onPressed: () => _toggleDone(todo),
                      ),

                      title: Text(
                        todo.todoText,

                        style: TextStyle(
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle: Text(todo.taskTime ?? ""),

                      trailing: IconButton(
                        onPressed: () async {
                          setState(() {
                            deletingTaskId = todo.id;
                          });

                          await Future.delayed(Duration(seconds: 2));

                          _deleteTask(todo.id);

                          setState(() {
                            deletingTaskId = null;
                          });
                        },

                        icon: deletingTaskId == todo.id
                            ? SizedBox(
                                width: 20,
                                height: 20,

                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.blue,
                                ),
                              )
                            : Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TaskSearchDelegate extends SearchDelegate {
  final List<Todo> todos;

  TaskSearchDelegate(this.todos);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),

        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),

      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = todos.where((todo) {
      return todo.todoText.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,

      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),

          title: Text(results[index].todoText),

          subtitle: Text(results[index].taskTime ?? ""),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
