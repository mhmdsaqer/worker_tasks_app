import 'package:flutter/material.dart';

class CustemButton extends StatelessWidget {
  CustemButton(
      {required this.icon,
      required this.text,
      required this.onPressed,
      super.key});

  String? text;
  Function? onPressed;
  dynamic? icon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.pink,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: () {
        onPressed!();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text!,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            icon
          ],
        ),
      ),
    );
  }
}
