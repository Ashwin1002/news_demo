import 'package:flutter/material.dart';

final _findTralingZero = RegExp(r'([.]*0+)(?!.*\d)');

extension NumExtension on num {
  SizedBox get horizontalSpace => SizedBox(width: toDouble());

  SizedBox get verticalSpace => SizedBox(height: toDouble());

  SliverToBoxAdapter get sliverHorizontalSpace =>
      SliverToBoxAdapter(child: horizontalSpace);

  SliverToBoxAdapter get sliverVerticalSpace =>
      SliverToBoxAdapter(child: verticalSpace);

  String get formatted => toString().replaceAll(_findTralingZero, '');

  String toInchesFormatted() {
    final int ft = this ~/ 12;
    final int inRem = (this % 12).round();
    return '$ft ft $inRem in';
  }
}
