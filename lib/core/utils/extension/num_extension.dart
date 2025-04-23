import 'package:flutter/material.dart';

extension NumExtension on num {
  SizedBox get horizontalSpace => SizedBox(width: toDouble());

  SizedBox get verticalSpace => SizedBox(height: toDouble());
}
