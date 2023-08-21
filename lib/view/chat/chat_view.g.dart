// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_view.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class ChatView extends StatelessWidget {
  const ChatView(
    this.data, {
    Key? key,
  }) : super(key: key);

  final void data;

  @override
  Widget build(BuildContext _context) => chatView(data);
}

class _ChatView extends StatelessWidget {
  const _ChatView(
    this.model, {
    Key? key,
  }) : super(key: key);

  final ChatViewModel model;

  @override
  Widget build(BuildContext _context) => __chatView(model);
}

class _MessageBox extends StatelessWidget {
  const _MessageBox(
    this.model, {
    Key? key,
  }) : super(key: key);

  final ChatViewModel model;

  @override
  Widget build(BuildContext _context) => __messageBox(model);
}
