import 'package:flutter/material.dart';

class DColors {
  DColors._();
  static const grey1 = Color(0xFFDADEE3);
  static const grey2 = Color(0xFFBDBDBD);
  static const grey3 = Color(0xFF797979);
  static const dark = Color(0xFF303030);
  static const primary = Color(0xFF424242);
  static const mapRouteBackground = Color(0xFF1D56C9);
  static const mapRoute = Color(0xFF159DFE);
  static const red = Color(0xFFDF2F45);
  static const lightWhite = Color(0xFFE1E1E1);
}

@immutable
class Color2 {
  final Color first;
  final Color second;
  static const primary = Color2(first: DColors.primary);

  const Color2({Color? first, Color? second})
      : first = first ?? Colors.transparent,
        second = second ?? Colors.transparent;

  Color2 withItem1(Color first) => Color2(first: first, second: second);
}
