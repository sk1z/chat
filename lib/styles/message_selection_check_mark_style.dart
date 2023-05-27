import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class MessageSelectionCheckMarkStyle
    extends ThemeExtension<MessageSelectionCheckMarkStyle> {
  const MessageSelectionCheckMarkStyle(
      {this.color, this.borderColor, this.size, this.margin, this.iconTheme});

  final Color? color;
  final Color? borderColor;
  final double? size;
  final EdgeInsetsGeometry? margin;
  final IconThemeData? iconTheme;

  @override
  ThemeExtension<MessageSelectionCheckMarkStyle> lerp(
      ThemeExtension<MessageSelectionCheckMarkStyle>? other, double t) {
    if (other is! MessageSelectionCheckMarkStyle) return this;

    return MessageSelectionCheckMarkStyle(
      color: Color.lerp(color, other.color, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      size: ui.lerpDouble(size, other.size, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      iconTheme: IconThemeData.lerp(iconTheme, other.iconTheme, t),
    );
  }

  @override
  MessageSelectionCheckMarkStyle copyWith() =>
      const MessageSelectionCheckMarkStyle();
}
