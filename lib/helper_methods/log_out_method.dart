import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:worker_tasks_app/screens/user_state.dart';

import '../screens/login_screen.dart';

Future<dynamic> logOutMethod(BuildContext context) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(children: [
            Icon(
              Icons.logout_rounded,
              color: Colors.red,
            ),
            SizedBox(
              width: 8,
            ),
            Text('Sign Out',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
          ]),
          content: Text(
            'Are you sure you want to log out ?',
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                _auth.signOut();
                Navigator.canPop(context) ? Navigator.pop(context) : null;
                Navigator.pushNamed(context, UserStateScreen.id);
              },
              child: Text(
                'Log Out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      });
}
