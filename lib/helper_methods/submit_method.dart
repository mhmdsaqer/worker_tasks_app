import 'package:flutter/material.dart';

bool submitMethod(BuildContext context, GlobalKey<FormState> key) {
  var isValid = key.currentState!.validate();
  FocusScope.of(context).unfocus();
  return isValid;
}
