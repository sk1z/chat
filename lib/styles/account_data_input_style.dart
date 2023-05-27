import 'package:flutter/material.dart';

class AccountDataInputStyle extends ThemeExtension<AccountDataInputStyle> {
  const AccountDataInputStyle({
    this.padding,
    this.decorationTheme,
  });

  final EdgeInsetsGeometry? padding;
  final InputDecorationTheme? decorationTheme;

  @override
  ThemeExtension<AccountDataInputStyle> lerp(
      ThemeExtension<AccountDataInputStyle>? other, double t) {
    if (other is! AccountDataInputStyle) return this;

    return AccountDataInputStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      decorationTheme: t < 0.5 ? decorationTheme : other.decorationTheme,
    );
  }

  @override
  AccountDataInputStyle copyWith() => const AccountDataInputStyle();
}
