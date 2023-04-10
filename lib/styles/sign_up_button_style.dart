import 'package:flutter/material.dart';

class SignUpButtonStyle extends ThemeExtension<SignUpButtonStyle> {
  const SignUpButtonStyle({this.padding, this.style});

  final EdgeInsetsGeometry? padding;
  final ButtonStyle? style;

  @override
  ThemeExtension<SignUpButtonStyle> lerp(
      ThemeExtension<SignUpButtonStyle>? other, double t) {
    if (other is! SignUpButtonStyle) return this;

    return SignUpButtonStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      style: ButtonStyle.lerp(style, other.style, t),
    );
  }

  @override
  SignUpButtonStyle copyWith() => SignUpButtonStyle();
}
