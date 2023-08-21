import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import '../../../locator.dart';
import '../../../resources/d_colors.dart';
import '../../../resources/dimens.dart';

part 'sender_chip.g.dart';

@swidget
Widget userChip(String sender) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: DDimens.s, horizontal: DDimens.m),
    decoration: const BoxDecoration(
      color: DColors.dark,
      borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
    ),
    child: Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          icon: const Icon(Icons.message),
          onPressed: () {},
        ),
        const Spacer(),
        IconButton(
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            onPressed: navigator.goBack,
            icon: const Icon(Icons.close, color: Colors.white))
      ],
    ),
  );
}
