
import 'package:flutter/material.dart';

import 'd_colors.dart';

final theme = ThemeData(
  primaryColor: DColors.dark,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'gotham',
  appBarTheme: const AppBarTheme(
    backgroundColor: DColors.dark,
    iconTheme: IconThemeData(color: Colors.white),
    titleSpacing: 0,
    centerTitle: true,
    elevation: 0,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: DColors.primary,
    primary: DColors.primary,
    secondary: DColors.primary,
    background: Colors.white,
  ),
);
