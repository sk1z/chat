import 'dart:ui';

import 'package:flutter/material.dart';

class ChatTileStyle extends ThemeExtension<ChatTileStyle> {
  const ChatTileStyle({
    this.height,
    this.contentPadding,
    this.avatarWidth,
    this.avatarSize,
    this.avatarColor,
    this.avatarTextStyle,
    this.nameHeight,
    this.nameStyle,
    this.messagePadding,
    this.messageStyle,
    this.sentTimePadding,
    this.sentTimeHeight,
    this.sentTimeStyle,
    this.dividerPadding,
    this.dividerHeight,
    this.dividerColor,
  });

  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final double? avatarWidth;
  final double? avatarSize;
  final Color? avatarColor;
  final TextStyle? avatarTextStyle;
  final double? nameHeight;
  final TextStyle? nameStyle;
  final EdgeInsetsGeometry? messagePadding;
  final TextStyle? messageStyle;
  final EdgeInsetsGeometry? sentTimePadding;
  final double? sentTimeHeight;
  final TextStyle? sentTimeStyle;
  final EdgeInsetsGeometry? dividerPadding;
  final double? dividerHeight;
  final Color? dividerColor;

  @override
  ThemeExtension<ChatTileStyle> lerp(
      ThemeExtension<ChatTileStyle>? other, double t) {
    if (other is! ChatTileStyle) return this;

    return ChatTileStyle(
      height: lerpDouble(height, other.height, t),
      contentPadding:
          EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t),
      avatarWidth: lerpDouble(avatarWidth, other.avatarWidth, t),
      avatarSize: lerpDouble(avatarSize, other.avatarSize, t),
      avatarColor: Color.lerp(avatarColor, other.avatarColor, t),
      avatarTextStyle:
          TextStyle.lerp(avatarTextStyle, other.avatarTextStyle, t),
      nameHeight: lerpDouble(nameHeight, other.nameHeight, t),
      nameStyle: TextStyle.lerp(nameStyle, other.nameStyle, t),
      messagePadding:
          EdgeInsetsGeometry.lerp(messagePadding, other.messagePadding, t),
      messageStyle: TextStyle.lerp(messageStyle, other.messageStyle, t),
      sentTimePadding:
          EdgeInsetsGeometry.lerp(sentTimePadding, other.sentTimePadding, t),
      sentTimeHeight: lerpDouble(sentTimeHeight, other.sentTimeHeight, t),
      sentTimeStyle: TextStyle.lerp(sentTimeStyle, other.sentTimeStyle, t),
      dividerPadding:
          EdgeInsetsGeometry.lerp(dividerPadding, other.dividerPadding, t),
      dividerHeight: lerpDouble(dividerHeight, other.dividerHeight, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
    );
  }

  @override
  ChatTileStyle copyWith() => const ChatTileStyle();
}
