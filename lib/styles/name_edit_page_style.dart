import 'package:flutter/material.dart';

class NameEditPageStyle extends ThemeExtension<NameEditPageStyle> {
  const NameEditPageStyle({this.backgroundColor});

  final Color? backgroundColor;

  @override
  ThemeExtension<NameEditPageStyle> lerp(
      ThemeExtension<NameEditPageStyle>? other, double t) {
    if (other is! NameEditPageStyle) return this;

    return NameEditPageStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
    );
  }

  @override
  NameEditPageStyle copyWith() => const NameEditPageStyle();
}
