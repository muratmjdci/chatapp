import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';
import '../../resources/strings/tr.dart';
import '../../routing/routes.dart';
import '../../services/persistence_service.dart';

class ChooseUsernameViewModel extends BaseViewModel {
  TextEditingController usernameController = TextEditingController();

  init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Cached.username.has) Routes.chat.call(replace: true);
    });
  }

  setUsername() async {
    if (usernameController.text.isEmpty || usernameController.text.trim().length < 3) return _invalidate();
    await Cached.username.set(usernameController.text);
    Routes.chat.call(replace: true);
  }

  _invalidate() {
    navigator.dialog(title: Tr.popupTitleError(), description: Tr.usernameInvalid());
  }
}
