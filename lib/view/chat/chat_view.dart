import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:stacked/stacked.dart';

import 'chat_view_model.dart';

part 'chat_view.g.dart';

@swidget
Widget chatView(void data) => ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
        ),
      ),
    );
