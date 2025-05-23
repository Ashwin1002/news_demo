import 'package:flutter/material.dart';

extension ScrollControllerExtensions on ScrollController {
  void onScrollEndsListener(
    final void Function() callback, {
    double offset = 0,
  }) {
    addListener(() {
      final maxScroll = position.maxScrollExtent;
      final currentScroll = position.pixels - offset;

      if (currentScroll == maxScroll) {
        callback();
      }
    });
  }

  bool get isBottom {
    if (!hasClients) return false;
    final maxScroll = position.maxScrollExtent;
    final currentScroll = offset;
    return currentScroll >= (maxScroll);
  }
}
