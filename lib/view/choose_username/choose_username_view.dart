import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';
import '../../resources/dimens.dart';
import '../../resources/strings/tr.dart';
import 'choose_username_view_model.dart';

part 'choose_username_view.g.dart';

@swidget
Widget chooseUsernameView(void data) => ViewModelBuilder<ChooseUsernameViewModel>.reactive(
      viewModelBuilder: () => ChooseUsernameViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, _) => Padding(
        padding: const EdgeInsets.all(DDimens.m),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: model.usernameController,
              onSaved: (_) => model.setUsername(),
              onTapOutside: (_) => navigator.closeKeyboard(),
              decoration: InputDecoration(labelText: Tr.setUserNameLabel()),
            ),
            const SizedBox(height: DDimens.m),
            SizedBox(
              height: DDimens.bs,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: model.setUsername,
                child: Text(Tr.setUserNameButton()),
              ),
            ),
          ],
        ),
      ),
    );
