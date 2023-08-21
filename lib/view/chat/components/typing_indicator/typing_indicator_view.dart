import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:stacked/stacked.dart';

import '../../../../resources/d_colors.dart';
import '../../../../resources/dimens.dart';
import 'typing_indicator_view_model.dart';

part 'typing_indicator_view.g.dart';

@hwidget
Widget typingIndicator() {
  final animation = useAnimationController(duration: const Duration(milliseconds: 300));
  final fade = Tween<double>(begin: 0.0, end: 1).animate(animation);
  animation.forward();
  return ViewModelBuilder<TypingIndicatorViewModel>.reactive(
    viewModelBuilder: () => TypingIndicatorViewModel(),
    builder: (__, model, _) {
      return FadeTransition(
        opacity: fade,
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (_, value, __) {
            return Transform.translate(
              offset: Offset(0, -tan(value) * 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: DDimens.s),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: DColors.grey1,
                      borderRadius: BorderRadius.circular(16).copyWith(bottomLeft: const Radius.circular(0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TweenAnimationBuilder(
                          curve: model.curve,
                          onEnd: model.onEnd,
                          duration: const Duration(milliseconds: 100),
                          tween: Tween<double>(begin: 0, end: model.end),
                          child: const _Circle(margin: 3, size: DDimens.s, color: Color2.primary),
                          builder: (_, double value, child) {
                            double offset = sin(value);
                            return Transform.translate(
                              offset: Offset(0, offset * 4),
                              child: child,
                            );
                          }),
                      TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 100),
                          curve: model.curve,
                          tween: Tween<double>(begin: 0, end: model.end - model.start),
                          child: const _Circle(margin: 3, size: DDimens.s, color: Color2.primary),
                          builder: (_, double value, child) {
                            double offset = sin(value);
                            return Transform.translate(
                              offset: Offset(0, offset * 4),
                              child: child,
                            );
                          }),
                      TweenAnimationBuilder(
                          curve: model.curve,
                          duration: const Duration(milliseconds: 100),
                          tween: Tween<double>(begin: 0, end: model.end - (model.start * 2)),
                          child: const _Circle(margin: 3, size: DDimens.s, color: Color2.primary),
                          builder: (_, double value, child) {
                            double offset = sin(value);
                            return Transform.translate(
                              offset: Offset(0, offset * 4),
                              child: child,
                            );
                          }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}


@swidget
Widget __circle({required Color2 color, double size = 4, double margin = DDimens.xs}) => Container(
  width: size,
  height: size,
  margin: EdgeInsets.all(margin),
  decoration: BoxDecoration(
    color: color.first,
    shape: BoxShape.circle,
    border: Border.all(width: 1, color: color.second),
  ),
);
