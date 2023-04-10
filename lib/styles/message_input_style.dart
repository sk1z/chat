import 'package:flutter/material.dart';

class MessageInputStyle extends ThemeExtension<MessageInputStyle> {
  const MessageInputStyle({
    this.constraints,
    this.color,
    this.messagePadding,
    this.messageDecorationTheme,
    this.cursorColor,
    this.messageStyle,
    this.sendButtonPadding,
    this.sendButtonIconTheme,
  });

  final BoxConstraints? constraints;
  final Color? color;
  final EdgeInsetsGeometry? messagePadding;
  final InputDecorationTheme? messageDecorationTheme;
  final Color? cursorColor;
  final TextStyle? messageStyle;
  final EdgeInsetsGeometry? sendButtonPadding;
  final IconThemeData? sendButtonIconTheme;

  @override
  ThemeExtension<MessageInputStyle> lerp(
      ThemeExtension<MessageInputStyle>? other, double t) {
    if (other is! MessageInputStyle) return this;

    return MessageInputStyle(
      constraints: BoxConstraints.lerp(constraints, other.constraints, t),
      color: Color.lerp(color, other.color, t),
      messagePadding:
          EdgeInsetsGeometry.lerp(messagePadding, other.messagePadding, t),
      messageDecorationTheme:
          t < 0.5 ? messageDecorationTheme : other.messageDecorationTheme,
      cursorColor: Color.lerp(cursorColor, other.cursorColor, t),
      messageStyle: TextStyle.lerp(messageStyle, other.messageStyle, t),
      sendButtonPadding: EdgeInsetsGeometry.lerp(
          sendButtonPadding, other.sendButtonPadding, t),
      sendButtonIconTheme:
          IconThemeData.lerp(sendButtonIconTheme, other.sendButtonIconTheme, t),
    );
  }

  @override
  MessageInputStyle copyWith() => MessageInputStyle();
}
