import 'package:flutter/material.dart';
import 'package:worker_tasks_app/screens/forget_password_screen.dart';
import 'package:worker_tasks_app/screens/home_screen.dart';
import 'package:worker_tasks_app/screens/login_screen.dart';
import 'package:worker_tasks_app/screens/register_screen.dart';

void main() {
  runApp(const WorkersTaskApp());
}

class WorkersTaskApp extends StatelessWidget {
  const WorkersTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEDE7DC),
          primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      title: "Workers Task",
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        ForgetPasswordScreen.id: (context) => ForgetPasswordScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
      home: HomeScreen(),
    );
  }
}
