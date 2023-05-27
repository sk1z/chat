import 'package:flutter/material.dart';

class AccountDataValidatorStyle
    extends ThemeExtension<AccountDataValidatorStyle> {
  const AccountDataValidatorStyle(
      {this.alignment, this.padding, this.errorStyle});

  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final TextStyle? errorStyle;

  @override
  ThemeExtension<AccountDataValidatorStyle> lerp(
      ThemeExtension<AccountDataValidatorStyle>? other, double t) {
    if (other is! AccountDataValidatorStyle) return this;

    return AccountDataValidatorStyle(
      alignment: AlignmentGeometry.lerp(alignment, other.alignment, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      errorStyle: TextStyle.lerp(errorStyle, other.errorStyle, t),
    );
  }

  @override
  AccountDataValidatorStyle copyWith() => const AccountDataValidatorStyle();
}
