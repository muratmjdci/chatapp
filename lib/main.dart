import 'package:chatappocr/resources/theme.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:injectable/injectable.dart';

import 'flavor_config.dart';

part 'main.g.dart';

run(Flavor runFlavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  flavor = runFlavor;
  runApp(const ChatApp());
}


@swidget
Widget chatApp(BuildContext context) {
  return MaterialApp(
    theme: theme,
    debugShowCheckedModeBanner: false,
    builder: (_, child) {
      if (!flavor.isRelease) child = Banner(location: BannerLocation.topStart, message: flavor.name, child: child);
      return child!;
    },
    home: const Scaffold(),
  );
}