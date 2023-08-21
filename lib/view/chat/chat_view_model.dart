import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../../data/message.dart';
import '../../data/socket_commands.dart';
import '../../services/chat_service.dart';
import '../../services/persistence_service.dart';
import '../../services/socket_service.dart';

class ChatViewModel extends ReactiveViewModel {
  final SocketService _socketService;
  final ChatService _chatService;

  ChatViewModel(this._socketService, this._chatService);

  List<Message> get messages => _chatService.messages;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  bool get _isTyping => messageController.text.isNotEmpty;
  bool typing = false;

  bool get canSend => messageController.text.trim().length > 1;
  final int maxLength = 240;

  init() async {
    await _socketService.connect();
    _chatService.messages.onChange.listen(_messageListener);
    _chatService.typing.addListener(_typingListener);
    messageController.addListener(_inputListener);
  }

  _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () async {
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  _messageListener(_) {
    notifyListeners();
    _scrollToBottom();
  }

  _typingListener() {
    typing = _chatService.typing.value;
    notifyListeners();
  }

  _inputListener() {
    if (_isTyping) return _sendTyping(true);
    return _sendTyping(false);
  }

  _sendTyping(bool start) {
    if (start == typing) return;
    typing = start;
    _socketService.send(SendTypingCommand(start));
  }

  void onSendMessage() {
    if (!canSend) return;
    final message = Message(message: messageController.text.trim(), sender: Cached.username.get);
    _send(message);
    notifyListeners();
  }

  _send(Message message) {
    _socketService.send(SendMessageCommand(message));
    _chatService.messages.add(message);
    messageController.clear();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_chatService];
}
