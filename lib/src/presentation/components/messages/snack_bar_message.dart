import 'package:flutter/material.dart';

class SnackBarMessage {
  // SnackBarMessage.show(context, message: "text");
  static show({required BuildContext context, required String message}) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
