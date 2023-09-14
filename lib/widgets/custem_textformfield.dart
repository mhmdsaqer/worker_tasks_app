import 'dart:ffi';

import 'package:flutter/material.dart';

class CustemTextFormField extends StatefulWidget {
  CustemTextFormField({
    required this.Controller,
    this.inputType,
    required this.hintString,
    this.focusNodee,
    this.onEditing,
    this.txtInputAction,
    this.filledd,
    this.filledColor,
    this.maxLen,
    this.maxLin,
  });

  TextEditingController? Controller;
  TextInputType? inputType;
  String? hintString;
  FocusNode? focusNodee;
  Function? onEditing;
  TextInputAction? txtInputAction;
  bool? filledd;
  Color? filledColor;
  int? maxLen;
  int? maxLin;

  @override
  State<CustemTextFormField> createState() => _CustemTextFormFieldState();
}

class _CustemTextFormFieldState extends State<CustemTextFormField> {
  bool un_visible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.hintString == 'Password' ? un_visible : false,
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
      textInputAction: widget.txtInputAction,
      style: TextStyle(color: Colors.white),
      controller: widget.Controller,
      keyboardType: widget.inputType == 'Position in the Company'
          ? null
          : widget.inputType,
      decoration: InputDecoration(
        filled: widget.filledd == true ? true : false,
        fillColor: widget.filledColor != null ? widget.filledColor : null,
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
        hintStyle: widget.filledd == true
            ? TextStyle(
                color: Colors.black,
              )
            : TextStyle(color: Colors.white),
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow)),
        errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red)),
      ),
      maxLength: widget.maxLen != null ? widget.maxLen : null,
      maxLines: widget.maxLin != null ? widget.maxLin : 1,
    );
    ;
  }
}
