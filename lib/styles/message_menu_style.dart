import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class MessageMenuStyle extends ThemeExtension<MessageMenuStyle> {
  const MessageMenuStyle(
      {this.clipBehavior, this.color, this.margin, this.shape, this.width});

  final Clip? clipBehavior;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final ShapeBorder? shape;
  final double? width;

  @override
  ThemeExtension<MessageMenuStyle> lerp(
      ThemeExtension<MessageMenuStyle>? other, double t) {
    if (other is! MessageMenuStyle) return this;

    return MessageMenuStyle(
      clipBehavior: t < 0.5 ? clipBehavior : other.clipBehavior,
      color: Color.lerp(color, other.color, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      shape: ShapeBorder.lerp(shape, other.shape, t),
      width: lerpDouble(width, other.width, t),
    );
  }

  @override
  MessageMenuStyle copyWith() => MessageMenuStyle();
}
