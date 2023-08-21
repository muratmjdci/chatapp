import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../resources/decorations.dart';
import '../resources/strings/tr.dart';
import '../routing/routes.dart';
import '../view/widget/custom_dialog.dart';

@lazySingleton
class NavigatorService {
  final routeObserver = RouteObserver<PageRoute>();
  final navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _currentState => navigatorKey.currentState;

  BuildContext? get _context => _currentState?.overlay?.context;

  BuildContext get context => _context!;

  ///navigates to the route with the given uri
  ///if replace is true, the current route will be replaced with the new route
  ///if clearStack is true, the current route will be replaced with the new route and the stack will be cleared
  ///returns a future with the result of the route
  ///example; navigator.navigateTo(Routes.chat.toUri(data: 1));
  Future<T?>? navigateTo<T>(Uri uri, {bool replace = false, bool clearStack = false}) {
    final route = uri.toString();
    if (clearStack) return _currentState?.pushNamedAndRemoveUntil(route, (r) => false);
    if (replace) return _currentState?.pushReplacementNamed(route);
    return _currentState?.pushNamed(route);
  }
  ///navigates back to the previous route
  void goBack<T extends Object>([T? result]) => _currentState?.pop(result);
  /// navigates back to the route before the current route
  void goBackUntil<T extends Object>(Routes until) => _currentState?.popUntil((r) => r.settings.name == until.name);

  /// shows a bottom sheet with a child widget
  /// if draggable is true, the bottom sheet can be dragged up and down
  bottomSheet({required Widget child, bool draggable = true}) => showModalBottomSheet(
    enableDrag: draggable,
    isScrollControlled: true,
    context: context,
    shape: bsBorder,
    builder: (context) => SafeArea(child: Padding(padding: MediaQuery.of(context).viewInsets, child: child)),
  );

  /// shows a dialog with a title, description, header, positive button and negative button(if provided)
  /// if persistent is true, the dialog can only be closed by pressing the negative or positive button
  /// if persistent is false, the dialog can be closed by pressing the back button or tapping outside the dialog
  dialog({
    String? title,
    String? description,
    Widget? header,
    String? negativeButtonText,
    Function()? negativeButtonAction,
    String? positiveButtonText,
    Function()? positiveButtonAction,
    bool persistent = false,
  }) =>
      showDialog(
        context: context,
        barrierDismissible: !persistent,
        builder: (_) => CustomDialogView(
          title: title,
          description: description,
          header: header,
          positiveButtonText: positiveButtonText ?? (persistent ? null : Tr.popupButtonText()),
          positiveButtonAction: positiveButtonAction ?? (persistent ? null : () => goBack()),
          negativeButtonText: negativeButtonText,
          negativeButtonAction: negativeButtonAction ?? () => goBack(),
        ),
      );

  closeKeyboard() => FocusScope.of(context).unfocus();
}
