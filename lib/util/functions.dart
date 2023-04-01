import 'package:flutter/material.dart';

void showSimpleAlertDialog(
  BuildContext context,
  String message,
) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        content: Text(message),
      );
    },
  );
}
