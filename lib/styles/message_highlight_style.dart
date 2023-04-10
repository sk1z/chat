import 'package:flutter/material.dart';

class MessageHighlightStyle extends ThemeExtension<MessageHighlightStyle> {
  const MessageHighlightStyle({this.color});

  final Color? color;

  @override
  ThemeExtension<MessageHighlightStyle> lerp(
      ThemeExtension<MessageHighlightStyle>? other, double t) {
    if (other is! MessageHighlightStyle) {
      return this;
    }

    return MessageHighlightStyle(color: Color.lerp(color, other.color, t));
  }

  @override
  MessageHighlightStyle copyWith({Color? color}) =>
      MessageHighlightStyle(color: color ?? this.color);
}
