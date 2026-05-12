import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:internship/home_page.dart';
import 'package:internship/sign_up.dart';
import 'Login_page.dart';
import 'firebase_options.dart';
import 'counter_page.dart';
import 'todo_list_app.dart';
import 'task_manager_app.dart';
import 'api_integration.dart';
import 'profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/signup',
      routes: {
        '/profile': (context) => const ProfilePage(),
        '/api': (context) => const ApiIntegration(),
        '/task': (context) => const TaskManagerApp(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/count': (context) => const CounterPage(),
        '/todo': (context) => const TodoListApp(),
        '/signup': (context) => const SignUp(),
      },
      
    );
  }
}
