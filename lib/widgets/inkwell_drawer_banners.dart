import 'package:flutter/material.dart';

class DrawerInkWell extends StatelessWidget {
  Function? ontap;
  IconData? icon;
  String? text;
  DrawerInkWell({
    required this.icon,
    required this.ontap,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap!();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25.0),
        child: Row(
          children: [
            text != 'Log out'
                ? Icon(icon!, color: Colors.black)
                : Icon(icon!, color: Colors.red),
            SizedBox(width: 12),
            Text(
              text!,
              style: text != 'Log out'
                  ? TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                  : TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
