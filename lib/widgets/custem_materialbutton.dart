import 'package:flutter/material.dart';

class CustemMaterialButton extends StatelessWidget {
  CustemMaterialButton(
      {required this.text,
      required this.buttonColor,
      required this.textColor,
      required this.onPressed,
      super.key});

  String? text;
  Function? onPressed;
  Color? textColor;
  Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: buttonColor!,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: () {
        onPressed!();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text!,
              style: TextStyle(color: textColor!),
            ),
          ],
        ),
      ),
    );
  }
}
