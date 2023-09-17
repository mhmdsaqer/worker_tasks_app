import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:worker_tasks_app/screens/home_screen.dart';
import 'package:worker_tasks_app/screens/login_screen.dart';
import 'package:worker_tasks_app/screens/register_screen.dart';

class UserStateScreen extends StatelessWidget {
  static String id = 'userStateScreen';
  const UserStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshots) {
          if (!userSnapshots.hasData) {
            return LoginScreen();
          } else if (userSnapshots.hasData) {
            return HomeScreen();
          } else {
            return MaterialApp(
              home: Scaffold(
                body: Center(child: Text('something went wrong , try again')),
              ),
            );
          }
        });
  }
}
