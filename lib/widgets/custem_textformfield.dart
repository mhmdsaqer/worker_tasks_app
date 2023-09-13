import 'dart:ffi';

import 'package:flutter/material.dart';

class CustemTextFormField extends StatefulWidget {
  CustemTextFormField({
    required this.Controller,
    required this.inputType,
    required this.hintString,
    this.vali,
  });

  TextEditingController? Controller;
  TextInputType? inputType;
  String? hintString;
  String? Function(String?)? vali;

  @override
  State<CustemTextFormField> createState() => _CustemTextFormFieldState();
}

class _CustemTextFormFieldState extends State<CustemTextFormField> {
  bool un_visible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (widget.hintString == 'Email') {
          if (value!.isEmpty || !value!.contains('@')) {
            return 'Please Enter a Valid Email';
          } else {
            return null;
          }
        } else if (widget.hintString == 'Password') {
          if (value!.isEmpty || value.length! < 7) {
            return 'Please Enter a Valid Password more than 7 letters';
          } else {
            return null;
          }
        } else if (value!.isEmpty) {
          return 'Please Enter the required fields';
        } else {
          return null;
        }
      },
      obscureText: widget.hintString == 'Password' ? un_visible : false,
      style: TextStyle(color: Colors.white),
      controller: widget.Controller,
      keyboardType: widget.inputType,
      decoration: InputDecoration(
        suffixIcon: widget.hintString == 'Password'
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    un_visible = !un_visible;
                  });
                },
                child: un_visible == true
                    ? Icon(Icons.visibility, color: Colors.white)
                    : Icon(Icons.visibility_off, color: Colors.white),
              )
            : null,
        hintText: widget.hintString == null ? 'null' : widget.hintString,
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
