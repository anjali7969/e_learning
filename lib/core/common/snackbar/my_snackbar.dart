import 'package:flutter/material.dart';

showMySnackBar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
  if (scaffoldMessenger == null) {
    throw FlutterError(
      'ScaffoldMessenger.of() called with a context that does not contain a ScaffoldMessenger.\n'
      'Make sure the context provided to showMySnackBar has a ScaffoldMessenger ancestor.',
    );
  }

  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color ?? Colors.green,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
