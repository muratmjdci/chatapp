import 'package:chatappocr/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

import '../locator.dart';
import '../resources/d_text_styles.dart';
import '../resources/strings/tr.dart';
import '../view/choose_username/choose_username_view.dart';



///enum for all routes in the app
///to navigate use Routes.chat();
///to navigate with extra arguments use Routes.chat.call([args]);
enum Routes<P> {
  chooseUsername(ChooseUsernameView.new);

  final bool wrap;
  final String? logo;
  final Tr? title;
  final Widget Function(P) _viewBuilder;

  // create appbar if logo or title is not null
  AppBar? get appBar => logo != null || title != null
      ? AppBar(title: title != null ? Text(title!(), style: DTextStyles.title) : null)
      : null;

  const Routes(this._viewBuilder, {this.logo, this.title, this.wrap = true});

  ///gets the [viewBuilder] from the enum
  ///example; Routes.chat.viewBuilder() will return ChatView()
  Widget viewBuilder(String? p) => _viewBuilder(_unmap(p));

  ///runs Uri.go() with the current route
  ///example; Routes.chat.call()
  Future<T?>? call<T>({P? data, bool replace = false, bool clearStack = false}) =>
      toUri(data: data).go(replace: replace, clearStack: clearStack);

  /// navigates back to the route before the current route
  /// example; Routes.chat.goBackUntil()
  void returnBack() => navigator.goBackUntil(this);
  /// converts the route to a uri
  Uri toUri({P? data}) => Uri(path: name, queryParameters: data != null ? {'q': _map(data)} : null);
}


///parsing data to string because uri can only contain strings
///example; if the type is int, it will parse the int to string
String _map(value) {
  if (value is Enum) return value.name;
  return value.toString();
}

///parsing data from string to the correct type
///example; if the type is int, it will parse the string to int
T _unmap<T>(String? param) {
  // determine the type of T
  if (T == int) return int.tryParse(param!)! as T;
  if (T == bool) return param?.parseBool() as T;
  return param as T;
}

extension UriRouteExtensions on Uri {
  /// Returns true if the path is the same as the route name
  bool contains(Routes route, [arg]) {
    if (path != route.name) return false;
    if (arg == null) return true;
    return queryParameters.values.contains(_map(arg));
  }

  /// Returns the route name from the path
  Routes get route => Routes.values.byName(path);

  /// Routes to the route
  Future<T?>? go<T>({bool replace = false, bool clearStack = false}) =>
      navigator.navigateTo(this, replace: replace, clearStack: clearStack);
}
