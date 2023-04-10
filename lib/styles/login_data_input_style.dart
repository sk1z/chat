import 'package:flutter/material.dart';

class LoginDataInputStyle extends ThemeExtension<LoginDataInputStyle> {
  const LoginDataInputStyle({this.padding, this.decorationTheme});

  final EdgeInsetsGeometry? padding;
  final InputDecorationTheme? decorationTheme;

  @override
  ThemeExtension<LoginDataInputStyle> lerp(
      ThemeExtension<LoginDataInputStyle>? other, double t) {
    if (other is! LoginDataInputStyle) return this;

    return LoginDataInputStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      decorationTheme: t < 0.5 ? decorationTheme : other.decorationTheme,
    );
  }

  @override
  LoginDataInputStyle copyWith() => LoginDataInputStyle();
}
