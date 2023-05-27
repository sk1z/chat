import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class MessageMenuItemStyle extends ThemeExtension<MessageMenuItemStyle> {
  const MessageMenuItemStyle(
      {this.height, this.iconPadding, this.iconTheme, this.titleStyle});

  final double? height;
  final EdgeInsetsGeometry? iconPadding;
  final IconThemeData? iconTheme;
  final TextStyle? titleStyle;

  @override
  ThemeExtension<MessageMenuItemStyle> lerp(
      ThemeExtension<MessageMenuItemStyle>? other, double t) {
    if (other is! MessageMenuItemStyle) return this;

    return MessageMenuItemStyle(
      height: lerpDouble(height, other.height, t),
      iconPadding: EdgeInsetsGeometry.lerp(iconPadding, other.iconPadding, t),
      iconTheme: IconThemeData.lerp(iconTheme, other.iconTheme, t),
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
    );
  }

  @override
  MessageMenuItemStyle copyWith() => const MessageMenuItemStyle();
}
