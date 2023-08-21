import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import '../../../data/message.dart';
import '../../../services/persistence_service.dart';

part 'message_widget.g.dart';

@hwidget
Widget messageChip(Message message, double width) {
  // final Sender sender = switch (message.sender) {  Cached.username.get => Sender.me, _ => Sender.other };
  final Sender sender = message.sender == Cached.username.get ? Sender.me : Sender.other;
  final animation = useAnimationController(duration: const Duration(milliseconds: 300));
  final fade = Tween<double>(begin: 0.0, end: 1).animate(animation);
  animation.forward();
  return FadeTransition(
    opacity: fade,
    child: TweenAnimationBuilder(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (_, value, ___) => Transform.translate(
          offset: Offset(0, -tan(value) * 4),
          child: Column(
            crossAxisAlignment: sender.crossAxisAlignment!,
            children: [
              Text(message.sender),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                constraints: BoxConstraints(maxWidth: width / 1.3),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: sender.color!,
                    borderRadius: BorderRadius.circular(8).copyWith(
                      bottomRight: Radius.circular(sender == Sender.other ? 8 : 0),
                      bottomLeft: Radius.circular(sender == Sender.other ? 0 : 8),
                    )),
                child: Text(
                  message.message,
                  style: TextStyle(color: sender.textColor),
                ),
              ),
            ],
          )),
    ),
  );
}

// enum Sender {
//   other(
//     1,
//     color: Color(0xffEEEEEE),
//     alignment: Alignment.centerLeft,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     textColor: Colors.black,
//   ),
//   me(2,
//       color: Color(0xFF303030),
//       alignment: Alignment.centerRight,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       textColor: Colors.white);
//
//   final String sender;
//   final Color? color;
//   final Alignment? alignment;
//   final CrossAxisAlignment? crossAxisAlignment;
//   final Color? textColor;
//
//   const Sender(this.sender, {this.color, this.alignment, this.crossAxisAlignment, this.textColor});
// }

class Sender {
  static final other = Sender(Cached.username.get,
      color: Color(0xffEEEEEE),
      alignment: Alignment.centerLeft,
      crossAxisAlignment: CrossAxisAlignment.start,
      textColor: Colors.black);
  static const me = Sender("other",
      color: Color(0xFF303030),
      alignment: Alignment.centerRight,
      crossAxisAlignment: CrossAxisAlignment.end,
      textColor: Colors.white);

  final String sender;
  final Color? color;
  final Alignment? alignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final Color? textColor;

  const Sender(this.sender, {this.color, this.alignment, this.crossAxisAlignment, this.textColor});
}
