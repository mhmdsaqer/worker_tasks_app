import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:worker_tasks_app/screens/home_screen.dart';
import 'package:worker_tasks_app/screens/inner_screens/add_task_screen.dart';
import 'package:worker_tasks_app/screens/inner_screens/all_workers.dart';
import 'package:worker_tasks_app/screens/login_screen.dart';
import 'package:worker_tasks_app/screens/register_screen.dart';
import 'package:worker_tasks_app/screens/user_state.dart';
import 'package:worker_tasks_app/widgets/task_details.dart';
import 'package:worker_tasks_app/widgets/worker_details_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WorkersTaskApp());
}

class WorkersTaskApp extends StatelessWidget {
  WorkersTaskApp({super.key});
  final Future<FirebaseApp> _appInitialzation = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _appInitialzation,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(child: Text('Error')),
              ),
            );
          }
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
              WorkerDetailsWidget.id: (context) => WorkerDetailsWidget(),
              TaskDetailsWidget.id: (context) => TaskDetailsWidget(),
              UserStateScreen.id: (context) => UserStateScreen(),
            },
            home: UserStateScreen(),
          );
        });
  }
}
