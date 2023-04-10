import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class HeaderStyle extends ThemeExtension<HeaderStyle> {
  const HeaderStyle({
    this.height,
    this.titlePadding,
    this.titleHeight,
    this.titleStyle,
    this.wideHeight,
    this.wideTitlePadding,
  });

  final double? height;
  final EdgeInsetsGeometry? titlePadding;
  final double? titleHeight;
  final TextStyle? titleStyle;
  final double? wideHeight;
  final EdgeInsetsGeometry? wideTitlePadding;

  @override
  ThemeExtension<HeaderStyle> lerp(
      ThemeExtension<HeaderStyle>? other, double t) {
    if (other is! HeaderStyle) return this;

    return HeaderStyle(
      height: lerpDouble(height, other.height, t),
      titlePadding:
          EdgeInsetsGeometry.lerp(titlePadding, other.titlePadding, t),
      titleHeight: lerpDouble(titleHeight, other.titleHeight, t),
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
      wideHeight: lerpDouble(wideHeight, other.wideHeight, t),
      wideTitlePadding:
          EdgeInsetsGeometry.lerp(wideTitlePadding, other.wideTitlePadding, t),
    );
  }

  @override
  HeaderStyle copyWith() => HeaderStyle();
}
