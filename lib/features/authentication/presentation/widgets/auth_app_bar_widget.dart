import 'package:comments/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

AppBar authAppBar(String text) {
  return AppBar(
    title: Text(
      text,
      style: const TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold),
    ),
    elevation: 0,
    backgroundColor: AppTheme.lightColor,
    centerTitle: false,
  );
}
