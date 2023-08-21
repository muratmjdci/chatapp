import 'package:flutter/material.dart';

import 'd_colors.dart';

class DTextStyles {
  static const darkLight = TextStyle(
    color: DColors.dark,
    fontWeight: FontWeight.w300,
    fontStyle: FontStyle.normal,
    fontSize: 14.0,
  );
  static const darkBold = TextStyle(
    color: DColors.grey3,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 18.0,
  );

  static const title = TextStyle(
    color: DColors.grey3,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontSize: 20.0,
  );
}
