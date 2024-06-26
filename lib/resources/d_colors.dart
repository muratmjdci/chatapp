import 'package:flutter/material.dart';

class DColors {
  DColors._();
  static const grey0 = Color(0xFFF9F9F9);
  static const grey1 = Color(0xFFDADEE3);
  static const grey2 = Color(0xFFBDBDBD);
  static const grey3 = Color(0xFF797979);
  static const barrier = Color(0x609E9E9E);
  static const dark = Color(0xFF303030);
  static const primary = Color(0xFF424242);
  static const secondary = red;
  static const red = Color(0xFFDF2F45);
  static const redBackground = Color(0xFFFCE8DB);
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
