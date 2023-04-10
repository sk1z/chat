import 'package:flutter/material.dart';

class NameEditFormStyle extends ThemeExtension<NameEditFormStyle> {
  const NameEditFormStyle({this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  ThemeExtension<NameEditFormStyle> lerp(
      ThemeExtension<NameEditFormStyle>? other, double t) {
    if (other is! NameEditFormStyle) return this;

    return NameEditFormStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
    );
  }

  @override
  NameEditFormStyle copyWith() => NameEditFormStyle();
}
