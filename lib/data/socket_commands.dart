import 'message.dart';

/// socket commands
/// 1 -> send message
/// 2 -> send typing

/// This class is used to parse the outgoing socket command
/// and return the appropriate command
sealed class OutGoingSocketCommand {
  final int command;

  const OutGoingSocketCommand(this.command);

  Map<String, dynamic> toJson() => {'command': command};
}

class SendMessageCommand extends OutGoingSocketCommand {
  final Message message;

  const SendMessageCommand(this.message) : super(1);

  @override
  Map<String, dynamic> toJson() => {'command': command, 'message': message.message, 'sender': message.sender};
}

class SendTypingCommand extends OutGoingSocketCommand {
  final bool typing;

  const SendTypingCommand(this.typing) : super(2);

  @override
  Map<String, dynamic> toJson() => {'command': command, 'typing': typing};
}

/// This class is used to parse the incoming socket command
/// and return the appropriate command
sealed class IncomingSocketCommand {
  const IncomingSocketCommand();

  factory IncomingSocketCommand.fromJson(Map<String, dynamic> json) => switch (json) {
        {'command': 1} => NewMessageCommand(json['message'], json['sender']),
        {'command': 2} => TypingCommand(json['typing']),
        _ => const NoCommand(),
      };
}

sealed class IncomingChatCommand extends IncomingSocketCommand {
  const IncomingChatCommand();
}

class NewMessageCommand extends IncomingChatCommand {
  final String message;
  final String sender;

  const NewMessageCommand(this.message, this.sender);
}

class TypingCommand extends IncomingChatCommand {
  final bool typing;

  const TypingCommand(this.typing);
}

class NoCommand extends IncomingSocketCommand {
  const NoCommand();
}
