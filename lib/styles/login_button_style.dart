import 'package:flutter/material.dart';

class LoginButtonStyle extends ThemeExtension<LoginButtonStyle> {
  const LoginButtonStyle({this.padding, this.style});

  final EdgeInsetsGeometry? padding;
  final ButtonStyle? style;

  @override
  ThemeExtension<LoginButtonStyle> lerp(
      ThemeExtension<LoginButtonStyle>? other, double t) {
    if (other is! LoginButtonStyle) return this;

    return LoginButtonStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      style: ButtonStyle.lerp(style, other.style, t),
    );
  }

  @override
  LoginButtonStyle copyWith() => const LoginButtonStyle();
}
