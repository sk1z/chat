import 'package:flutter/material.dart';

class SignUpPageStyle extends ThemeExtension<SignUpPageStyle> {
  const SignUpPageStyle({this.backgroundColor});

  final Color? backgroundColor;

  @override
  ThemeExtension<SignUpPageStyle> lerp(
      ThemeExtension<SignUpPageStyle>? other, double t) {
    if (other is! SignUpPageStyle) return this;

    return SignUpPageStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
    );
  }

  @override
  SignUpPageStyle copyWith() => const SignUpPageStyle();
}
