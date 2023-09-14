import 'package:flutter/material.dart';

void submitMethod(BuildContext context, GlobalKey<FormState> key) {
  var isValid = key.currentState!.validate();
  FocusScope.of(context).unfocus();
}
