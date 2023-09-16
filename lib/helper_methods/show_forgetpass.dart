import 'package:flutter/material.dart';

import '../constants.dart';

Future<dynamic> showPassWidget(BuildContext context,
    TextEditingController forgetpass, GlobalKey<FormState> forgetKey) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Text(
                'Close',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () {
                bool? isValid = forgetKey.currentState!.validate();
                FocusScope.of(context).unfocus();
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.green),
              ))
        ],
        title: Text('Forget Your Email'),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          //height: MediaQuery.of(context).size.height * 0.5,
          child: ListView(shrinkWrap: true, children: [
            Text('Please enter your email '),
            SizedBox(
              height: 20,
            ),
            Form(
              key: forgetKey,
              child: TextFormField(
                controller: forgetpass,
                validator: (value) {
                  if (value!.isEmpty || !value!.contains('@')) {
                    return ('Please Enter a valid email');
                  }
                },
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.pink.shade800,
                    ),
                    hintText: 'Enter Your Email',
                    hintStyle: TextStyle(color: Colors.pink.shade800),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black)),
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.red)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.pink.shade800))),
              ),
            ),
          ]),
        ),
      );
    },
  );
}
