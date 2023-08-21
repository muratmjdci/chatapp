// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typing_indicator_view.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class TypingIndicator extends HookWidget {
  const TypingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => typingIndicator();
}

class _Circle extends StatelessWidget {
  const _Circle({
    Key? key,
    required this.color,
    this.size = 4,
    this.margin = DDimens.xs,
  }) : super(key: key);

  final Color2 color;

  final double size;

  final double margin;

  @override
  Widget build(BuildContext _context) => __circle(
        color: color,
        size: size,
        margin: margin,
      );
}
