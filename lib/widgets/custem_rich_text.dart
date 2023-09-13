import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustemRichText extends StatelessWidget {
  CustemRichText(
      {required this.onTap,
      required this.text_one,
      required this.text_two,
      required this.aligment,
      super.key});
  String? text_one;
  String? text_two;
  Function? onTap;
  dynamic? aligment;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: aligment,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: text_one, style: TextStyle(color: Colors.white)),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  onTap!();
                },
              text: text_two,
              style: const TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
            )
          ],
        ),
      ),
    );
  }
}
