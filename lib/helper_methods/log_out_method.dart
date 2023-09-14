import 'package:flutter/material.dart';

Future<dynamic> logOutMethod(BuildContext context) {
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
                // Navigator.pushNamed(context, LoginScreen.id);
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
