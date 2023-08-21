import 'dart:math';

import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';
import '../../resources/d_colors.dart';
import '../../resources/dimens.dart';
import 'chat_view_model.dart';
import 'components/message_widget.dart';
import 'components/typing_indicator/typing_indicator_view.dart';

part 'chat_view.g.dart';

@swidget
Widget chatView(void data) => ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(sl(), sl()),
      onViewModelReady: (model) => model.init(),
      builder: (c, model, _) => Scaffold(
        appBar: AppBar(title: const Text("Chat app")),
        body: Column(
          children: [
            const SizedBox(height: DDimens.m),
            _ChatView(model),
            _MessageBox(model),
            SizedBox(height: MediaQuery.paddingOf(c).bottom)
          ],
        ),
      ),
    );

@swidget
Widget __chatView(ChatViewModel model) {
  return Expanded(
    child: Column(children: [
      Expanded(
        child: ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const AlwaysScrollableScrollPhysics(),
            controller: model.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: DDimens.s),
            itemCount: model.messages.length + (model.typing ? 1 : 0),
            itemBuilder: (context, index) {
              if (model.typing && index == model.messages.length) return const TypingIndicator();
              final message = model.messages[index];
              final width = MediaQuery.sizeOf(context).width;
              return MessageChip(message, width);
            }),
      ),
      const SizedBox(height: DDimens.m),
    ]),
  );
}

@swidget
Widget __messageBox(ChatViewModel model) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: TextFormField(
          controller: model.messageController,
          focusNode: model.focusNode,
          textAlignVertical: TextAlignVertical.top,
          maxLines: 3,
          minLines: 2,
          maxLength: 240,
          // onChanged: (value) => model.onMessageChanged(value),
          decoration: InputDecoration(
              isDense: true,
              counterText: "",
              suffixIcon: IconButton(
                splashRadius: 1,
                enableFeedback: false,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                onPressed: model.onSendMessage,
                alignment: Alignment.bottomCenter,
                icon: Transform.rotate(
                    angle: -45 * pi / 180,
                    child: Icon(
                      Icons.send,
                      color: model.canSend ? Colors.black : Colors.black45,
                    )),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: DColors.lightWhite),
              )),
        ),
      ),
    ],
  );
}
