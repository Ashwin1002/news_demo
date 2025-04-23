import 'dart:math' as math;

import 'package:flutter/material.dart';

const kMaxDesktopWidth = 1920.0;
const kStandardDesktopWidth = 1024.0;
const kTabletBreakPoint = 768.0;
const kMobileBreakPoint = 375.0;

const kMaxDesktopHeight = 1080.0;
const kStandardDesktopHeight = 900.0;
const kTabletBreakPointHeight = 800.0;
const kMobileBreakPointHeight = 667.0;

const kMaxDesktopScale = 1.2;
const kDesktopScale = 1.1;
const kTabletScale = 1.05;
const kMobileScale = .9;

class Device {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device's Height
  static late double height;

  /// Device's Width
  static late double width;

  /// pixel density
  static late double pixelDensity;

  /// Sets the Screen's size,
  /// `BoxConstraints`, `Height`, and `Width`
  static void setScreenSize(BuildContext context, BoxConstraints constraints) {
    boxConstraints = constraints;

    // Sets screen width and height
    width = boxConstraints.maxWidth;
    height = boxConstraints.maxHeight;

    pixelDensity = context.pixelDensity;
  }
}

extension ResponsiveExtensionOnContext on BuildContext {
  Size get size => MediaQuery.sizeOf(this);
  double get pixelDensity => MediaQuery.devicePixelRatioOf(this);

  double get width => size.width;
  double get height => size.height;
}

extension ResponsiveExtensionOnNum on num {
  double get h {
    double width = Device.width;
    double pixelDensity = Device.pixelDensity;
    double scaleFactor;

    if (width >= kMaxDesktopWidth) {
      scaleFactor = (width / kMaxDesktopWidth) * kMaxDesktopScale;
    } else if (width >= kStandardDesktopWidth) {
      scaleFactor = (width / kStandardDesktopWidth) * kDesktopScale;
    } else if (width >= kTabletBreakPoint) {
      scaleFactor = (width / kTabletBreakPoint) * kTabletScale;
    } else {
      scaleFactor = (width / kMobileBreakPoint) * kMobileScale;
    }

    scaleFactor = scaleFactor.clamp(.8, 1.4);

    return math.max(
      toDouble() * scaleFactor,
      (pixelDensity > 2 ? pixelDensity * .75 : 8.0),
    );
  }

  double get v {
    final deviceHeight = Device.height;
    final density = Device.pixelDensity;
    double scaleFactor;

    if (deviceHeight >= kMaxDesktopHeight) {
      scaleFactor = (deviceHeight / kMaxDesktopHeight) * kMaxDesktopScale;
    } else if (deviceHeight >= kStandardDesktopHeight) {
      scaleFactor = (deviceHeight / kStandardDesktopHeight) * kDesktopScale;
    } else if (deviceHeight >= kTabletBreakPointHeight) {
      scaleFactor = (deviceHeight / kTabletBreakPointHeight) * kTabletScale;
    } else {
      scaleFactor = (deviceHeight / kMobileBreakPointHeight) * kMobileScale;
    }

    scaleFactor = scaleFactor.clamp(0.8, 1.4);
    final scaledValue = toDouble() * scaleFactor;
    final minValue = density > 2 ? density * 0.75 : 8.0;
    return math.max(scaledValue, minValue);
  }
}
