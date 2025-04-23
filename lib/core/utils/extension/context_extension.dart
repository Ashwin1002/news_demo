import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  void showLoading() => showDialog(
    context: this,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: Dialog.fullscreen(
          backgroundColor: Colors.black26,
          child: Center(child: CircularProgressIndicator.adaptive()),
        ),
      );
    },
  );

  void popLoading() => Navigator.of(this).pop();
}
