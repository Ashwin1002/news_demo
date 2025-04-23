import 'package:flutter/material.dart';
import 'package:news_demo/core/core.dart';

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLightMode => !isDarkMode;

  void showLoading() => showDialog(
    context: this,
    barrierDismissible: false,
    builder: (context) {
      return const PopScope(
        canPop: false,
        child: Dialog.fullscreen(
          backgroundColor: Colors.black26,
          child: Center(child: CircularProgressIndicator.adaptive()),
        ),
      );
    },
  );

  void popLoading() => Navigator.of(this).pop();

  Future<T?> openBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool useSafeArea = true,
    bool showDragHandle = true,
    Color? backgroundColor,
    bool isDraggable = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    void Function()? tapOutside,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      showDragHandle: isDraggable ? null : showDragHandle,
      backgroundColor:
          isDraggable
              ? Colors.transparent
              : backgroundColor ?? colorScheme.surface,
      isDismissible: isDismissible,
      useRootNavigator: useRootNavigator,
      builder: (context) {
        if (isDraggable) {
          return Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context, null);
                  tapOutside?.call();
                },
                child: Container(
                  color: Colors.transparent,
                  height: context.height,
                  width: context.width,
                ),
              ),
              ClipRRect(child: child),
            ],
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.large,
            vertical: AppPadding.xlarge,
          ),
          child: child,
        );
      },
    );
  }
}
