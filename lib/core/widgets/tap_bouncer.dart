import 'package:flutter/cupertino.dart';

class TapBouncer extends StatefulWidget {
  const TapBouncer({super.key, this.onTap, required this.child});

  final VoidCallback? onTap;

  final Widget child;

  @override
  State<TapBouncer> createState() => _TapBouncerState();
}

class _TapBouncerState extends State<TapBouncer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        if (widget.onTap == null) return;

        // Animate bounce effect
        await _animationController.forward();
        await _animationController.reverse();

        widget.onTap?.call();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1 - _animationController.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
