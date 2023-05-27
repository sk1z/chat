import 'package:flutter/material.dart';

class LoginPageStyle extends ThemeExtension<LoginPageStyle> {
  const LoginPageStyle({this.backgroundColor});

  final Color? backgroundColor;

  @override
  ThemeExtension<LoginPageStyle> lerp(
      ThemeExtension<LoginPageStyle>? other, double t) {
    if (other is! LoginPageStyle) return this;

    return LoginPageStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
    );
  }

  @override
  LoginPageStyle copyWith() => const LoginPageStyle();
}
