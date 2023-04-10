import 'package:flutter/material.dart';

class SignUpTextButtonStyle extends ThemeExtension<SignUpTextButtonStyle> {
  const SignUpTextButtonStyle({this.textStyle});

  final TextStyle? textStyle;

  @override
  ThemeExtension<SignUpTextButtonStyle> lerp(
      ThemeExtension<SignUpTextButtonStyle>? other, double t) {
    if (other is! SignUpTextButtonStyle) return this;

    return SignUpTextButtonStyle(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
    );
  }

  @override
  SignUpTextButtonStyle copyWith() => SignUpTextButtonStyle();
}
