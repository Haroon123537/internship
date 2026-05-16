import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'task_manager_app.dart';
import 'todo_list_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isTaskLoading = false;
  bool isTodoLoading = false;
  bool isLogoutLoading = false;
  String name = '';
  String email = '';
  void getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get();
    setState(() {
      name = vari.data()?['name'];
      email = vari.data()?['email'];
    });
  }

  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,

          elevation: 3.0,
          shadowColor: Colors.black87,
          actions: [
            // TASK BUTTON
            IconButton(
              tooltip: "Task Manager",

              icon: isTaskLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(Icons.task_alt),

              color: Colors.white,
              iconSize: 24,
              hoverColor: Colors.white24,

              onPressed: isTaskLoading
                  ? null
                  : () async {
                      setState(() {
                        isTaskLoading = true;
                      });

                      await Future.delayed(Duration(seconds: 3));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TaskManagerApp(),
                        ),
                      );

                      setState(() {
                        isTaskLoading = false;
                      });
                    },
            ),

            SizedBox(width: 18),

            // TODO BUTTON
            IconButton(
              tooltip: "Todo List",

              icon: isTodoLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(Icons.check_circle_outline),

              color: Colors.white,
              iconSize: 24,
              hoverColor: Colors.white24,

              onPressed: isTodoLoading
                  ? null
                  : () async {
                      setState(() {
                        isTodoLoading = true;
                      });

                      await Future.delayed(Duration(seconds: 3));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TodoListApp(),
                        ),
                      );

                      setState(() {
                        isTodoLoading = false;
                      });
                    },
            ),

            SizedBox(width: 18),

            // LOGOUT BUTTON
            IconButton(
              tooltip: "Logout",

              icon: isLogoutLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(Icons.logout),

              color: Colors.white,
              iconSize: 24,
              hoverColor: Colors.white24,

              onPressed: isLogoutLoading
                  ? null
                  : () async {
                      setState(() {
                        isLogoutLoading = true;
                      });

                      await Future.delayed(Duration(seconds: 3));

                      await FirebaseAuth.instance.signOut();

                      Navigator.pushNamed(context, '/login');

                      setState(() {
                        isLogoutLoading = false;
                      });
                    },
            ),

            SizedBox(width: 15),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                leading: Icon(Icons.task_alt),
                title: Text('Tasks Management'),
                onTap: () {
                  Navigator.pushNamed(context, '/task');
                },
              ),
              ListTile(
                leading: Icon(Icons.api),
                title: Text('ToDo List'),
                onTap: () {
                  Navigator.pushNamed(context, '/todo');
                },
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.indigo, Colors.lightBlue]),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height: 70),

                Text(
                  ' Welcome to the Glamourous',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 30),
                Text(name, style: TextStyle(fontSize: 30, color: Colors.white)),
                SizedBox(height: 15),
                Text(
                  email,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
