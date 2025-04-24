import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_demo/core/core.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title,
    this.hasShadow,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.automaticallyImplyLeading = true,
  });

  final Widget? title;
  final bool? hasShadow;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoNavigationBar(
        backgroundColor: backgroundColor ?? context.colorScheme.surfaceBright,
        automaticallyImplyMiddle: automaticallyImplyLeading,
        middle: title,
        trailing: actions?.firstOrNull,
        // actions: actions,
      );
    }
    return AppBar(
      elevation: 4.0,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      shadowColor: hasShadow != true ? null : context.colorScheme.shadow,
      titleTextStyle: context.textTheme.titleMedium?.copyWith(
        color: foregroundColor,
      ),
      title: title,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
