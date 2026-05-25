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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isTaskLoading = false;
  bool isTodoLoading = false;
  bool isLogoutLoading = false;
  late Animation<double> _bounceAnimation;
  String name = '';
  String email = '';
  bool animate = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
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

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,

      duration: Duration(seconds: 4),
    )..repeat(reverse: true);

    _slideAnimation = Tween<Offset>(
      begin: Offset(-1.5, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticInOut));
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Hero(
        tag: "home_icon",
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,

            elevation: 3.0,
            shadowColor: Colors.black87,
            actions: [
              
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
                          
                          // ignore: use_build_context_synchronously
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
                          // ignore: use_build_context_synchronously
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

                        // ignore: use_build_context_synchronously
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
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    'Menu',
                    style: TextStyle(color: Colors.white, fontSize: 24),
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
          body: AnimatedBuilder(
            animation: _controller,

            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,

                    end: Alignment.bottomRight,

                    colors: [
                      Color.lerp(
                        Colors.blue,
                        Colors.purple,
                        _controller.value,
                      )!,

                      Color.lerp(
                        Colors.black,
                        Colors.indigo,
                        _controller.value,
                      )!,
                    ],
                  ),
                ),

                child: child,
              );
            },

            child: Align(
              alignment: Alignment.topCenter,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
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
                      Text(
                        name,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      SizedBox(height: 15),
                      Text(
                        email,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(height: 30),
                      ScaleTransition(
                        scale: _bounceAnimation,
                        child: ElevatedButton(
                          onPressed: getData,
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black87,
                            elevation: 5,
                            //outlineColor: Colors.white,
                            overlayColor: Colors.white24,
                            foregroundColor: Colors.blue,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 20,
                            ),
                            textStyle: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text(
                            'Click here to create',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
