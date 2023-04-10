import 'package:flutter/material.dart';

class MessageListStyle extends ThemeExtension<MessageListStyle> {
  const MessageListStyle({this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  ThemeExtension<MessageListStyle> lerp(
      ThemeExtension<MessageListStyle>? other, double t) {
    if (other is! MessageListStyle) return this;

    return MessageListStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
    );
  }

  @override
  MessageListStyle copyWith() => MessageListStyle();
}
