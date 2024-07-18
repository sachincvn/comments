import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String? content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content ?? "Something went wrong"),
      ),
    );
}

void showErrorSnackBar(BuildContext context, String? content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          content ?? "Something went wrong",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      ),
    );
}
