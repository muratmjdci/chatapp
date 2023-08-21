import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../data/message.dart';
import '../data/socket_commands.dart';

@lazySingleton
class ChatService with ListenableServiceMixin {
  onNewMessage(IncomingChatCommand command) {
    return switch (command) {
      NewMessageCommand() => _onNewMessage(command),
      TypingCommand() => _updateTypingStatus(command.typing),
    };
  }

  _onNewMessage(NewMessageCommand command) => messages.add(Message(message: command.message, sender: command.sender));

  _updateTypingStatus(bool isTyping) => typing.value = isTyping;

  reset() {
    typing.value = false;
    messages.clear();
  }

  final typing = ValueNotifier(false);
  final ReactiveList<Message> messages = ReactiveList<Message>();
}
