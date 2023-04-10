import 'package:flutter/material.dart';

class NameInputStyle extends ThemeExtension<NameInputStyle> {
  const NameInputStyle({
    this.padding,
    this.decorationTheme,
    this.textStyle,
  });

  final EdgeInsetsGeometry? padding;
  final InputDecorationTheme? decorationTheme;
  final TextStyle? textStyle;

  @override
  ThemeExtension<NameInputStyle> lerp(
      ThemeExtension<NameInputStyle>? other, double t) {
    if (other is! NameInputStyle) return this;

    return NameInputStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      decorationTheme: t < 0.5 ? decorationTheme : other.decorationTheme,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
    );
  }

  @override
  NameInputStyle copyWith() => NameInputStyle();
}
