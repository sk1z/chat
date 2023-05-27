import 'package:flutter/material.dart';

class SignUpFormStyle extends ThemeExtension<SignUpFormStyle> {
  const SignUpFormStyle({this.alignment, this.padding});

  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  @override
  ThemeExtension<SignUpFormStyle> lerp(
      ThemeExtension<SignUpFormStyle>? other, double t) {
    if (other is! SignUpFormStyle) return this;

    return SignUpFormStyle(
      alignment: AlignmentGeometry.lerp(alignment, other.alignment, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
    );
  }

  @override
  SignUpFormStyle copyWith() => const SignUpFormStyle();
}
