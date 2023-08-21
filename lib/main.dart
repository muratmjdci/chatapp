import 'dart:io';
import 'package:chatappocr/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import 'flavor_config.dart';
import 'locator.dart';
import 'resources/theme.dart';

part 'main.g.dart';

run(Flavor runFlavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  flavor = runFlavor;
  configureDependencies();
  await initDependencies();
  runApp(const ChatApp());
}

@swidget
Widget chatApp(BuildContext context) {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: theme,
    builder: (_, child) {
      if (!flavor.isRelease) child = Banner(location: BannerLocation.topStart, message: flavor.name, child: child);
      return child!;
    },
    navigatorKey: navigator.navigatorKey,
    navigatorObservers: [navigator.routeObserver],
    onGenerateRoute: (settings) => onGenerateRoute(settings),
    initialRoute: 'chooseUsername',
  );
}
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  return (Platform.isIOS ? CupertinoPageRoute.new : MaterialPageRoute.new)(
      settings: settings,
      builder: (_) {
        final uri = Uri.parse(settings.name!);
        final route = uri.route;
        Widget child = route.viewBuilder(uri.queryParameters['q']);
        if (route.wrap) child = Scaffold(appBar: route.appBar, body: SafeArea(child: child));
        return child;
      });
}
