import 'package:flutter/material.dart';

class CustemTextFormField extends StatelessWidget {
  CustemTextFormField({
    required this.Controller,
    required this.inputType,
    required this.hintString,
    this.passSecurity,
  });

  TextEditingController? Controller;
  TextInputType? inputType;
  String? hintString;
  bool? passSecurity;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: Controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintString == null ? 'null' : hintString,
        hintStyle: TextStyle(color: Colors.white),
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow)),
        errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
      ),
    );
    ;
  }
}
