import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class LoginFormStyle extends ThemeExtension<LoginFormStyle> {
  const LoginFormStyle(
      {this.alignment, this.padding, this.logoPadding, this.logoHeight});

  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? logoPadding;
  final double? logoHeight;

  @override
  ThemeExtension<LoginFormStyle> lerp(
      ThemeExtension<LoginFormStyle>? other, double t) {
    if (other is! LoginFormStyle) return this;

    return LoginFormStyle(
      alignment: AlignmentGeometry.lerp(alignment, other.alignment, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      logoPadding: EdgeInsetsGeometry.lerp(logoPadding, other.logoPadding, t),
      logoHeight: lerpDouble(logoHeight, other.logoHeight, t),
    );
  }

  @override
  LoginFormStyle copyWith() => LoginFormStyle();
}
