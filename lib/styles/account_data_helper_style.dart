import 'package:flutter/material.dart';

class AccountDataHelperStyle extends ThemeExtension<AccountDataHelperStyle> {
  const AccountDataHelperStyle({this.alignment, this.padding, this.textStyle});

  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  @override
  ThemeExtension<AccountDataHelperStyle> lerp(
      ThemeExtension<AccountDataHelperStyle>? other, double t) {
    if (other is! AccountDataHelperStyle) return this;

    return AccountDataHelperStyle(
      alignment: AlignmentGeometry.lerp(alignment, other.alignment, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
    );
  }

  @override
  AccountDataHelperStyle copyWith() => AccountDataHelperStyle();
}
