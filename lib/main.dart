import 'package:flutter/material.dart';
import 'package:worker_tasks_app/screens/home_screen.dart';
import 'package:worker_tasks_app/screens/inner_screens/add_task_screen.dart';
import 'package:worker_tasks_app/screens/inner_screens/all_workers.dart';
import 'package:worker_tasks_app/screens/login_screen.dart';
import 'package:worker_tasks_app/screens/register_screen.dart';
import 'package:worker_tasks_app/widgets/worker_widget.dart';

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
        RegisterScreen.id: (context) => RegisterScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        AddTaskScreen.id: (context) => AddTaskScreen(),
        AllWorkersScreen.id: (context) => AllWorkersScreen(),
        WorkerWidget.id: (context) => WorkerWidget(),
      },
      home: LoginScreen(),
    );
  }
}
