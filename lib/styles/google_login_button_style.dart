import 'package:flutter/material.dart';

class GoogleLoginButtonStyle extends ThemeExtension<GoogleLoginButtonStyle> {
  const GoogleLoginButtonStyle(
      {this.padding, this.style, this.iconTheme, this.labelStyle});

  final EdgeInsetsGeometry? padding;
  final ButtonStyle? style;
  final IconThemeData? iconTheme;
  final TextStyle? labelStyle;

  @override
  ThemeExtension<GoogleLoginButtonStyle> lerp(
      ThemeExtension<GoogleLoginButtonStyle>? other, double t) {
    if (other is! GoogleLoginButtonStyle) return this;

    return GoogleLoginButtonStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      style: ButtonStyle.lerp(style, other.style, t),
      iconTheme: IconThemeData.lerp(iconTheme, other.iconTheme, t),
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t),
    );
  }

  @override
  GoogleLoginButtonStyle copyWith() => GoogleLoginButtonStyle();
}
