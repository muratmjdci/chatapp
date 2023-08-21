import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:stacked/stacked.dart';

import 'choose_username_view_model.dart';

part 'choose_username_view.g.dart';

@swidget
Widget chooseUsernameView(void data) => ViewModelBuilder<ChooseUsernameViewModel>.reactive(
      viewModelBuilder: () => ChooseUsernameViewModel(),
      builder: (context, model, _) => Scaffold(
          appBar: AppBar(
        title: Text('Choose Username'),
      )),
    );

/*
TODO add these to routes
import 'package:chatappocr/view/choose_username/choose_username_view.dart';
chooseUsername(ChooseUsernameView.new),
*/
