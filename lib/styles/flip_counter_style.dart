import 'package:flutter/material.dart';

class FlipCounterStyle extends ThemeExtension<FlipCounterStyle> {
  const FlipCounterStyle(
      {this.padding, this.mainAxisAlignment, this.textStyle});

  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment? mainAxisAlignment;
  final TextStyle? textStyle;

  @override
  ThemeExtension<FlipCounterStyle> lerp(
      ThemeExtension<FlipCounterStyle>? other, double t) {
    if (other is! FlipCounterStyle) return this;

    return FlipCounterStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      mainAxisAlignment: t < 0.5 ? mainAxisAlignment : other.mainAxisAlignment,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
    );
  }

  @override
  FlipCounterStyle copyWith() => FlipCounterStyle();
}
