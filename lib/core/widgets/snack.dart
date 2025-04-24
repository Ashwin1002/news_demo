import 'package:flutter/material.dart';
import 'package:news_demo/core/core.dart';

const _kSnackDuration = Duration(milliseconds: 2500);

class Snack {
  static void _show(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Duration? duration,
    IconData? icon,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: duration ?? _kSnackDuration,
          backgroundColor: backgroundColor,
          content: Row(
            spacing: 12.0,
            children: [
              if (icon != null) Icon(icon, color: context.colorScheme.surface),
              Flexible(child: Text(message)),
            ],
          ),
          elevation: 4,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  static void success(BuildContext context, String message, [IconData? icon]) {
    _show(
      context,
      message,
      backgroundColor: context.colorScheme.primary,
      icon: Icons.check,
    );
  }

  static void error(BuildContext context, String message, [IconData? icon]) {
    _show(
      context,
      message,
      icon: Icons.error_outline_outlined,
      backgroundColor: context.colorScheme.onErrorContainer,
    );
  }
}
