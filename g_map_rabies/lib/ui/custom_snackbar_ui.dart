import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    Key? key,
    required String message,
    String btnLabel = 'OK',
    Duration duration = const Duration(seconds: 5),
    Color backgroundColor = const Color.fromARGB(255, 43, 226, 6),
    VoidCallback? onOk,
  }) : super(
            key: key,
            content: Text(message),
            duration: duration,
            backgroundColor: backgroundColor,
            action: SnackBarAction(
                label: btnLabel,
                onPressed: () {
                  if (onOk != null) onOk();
                }));
}
