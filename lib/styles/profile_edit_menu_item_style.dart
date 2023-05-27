import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class ProfileEditMenuItemStyle
    extends ThemeExtension<ProfileEditMenuItemStyle> {
  const ProfileEditMenuItemStyle({
    this.height,
    this.contentPadding,
    this.iconWidth,
    this.iconTheme,
    this.titleStyle,
  });

  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final double? iconWidth;
  final IconThemeData? iconTheme;
  final TextStyle? titleStyle;

  @override
  ThemeExtension<ProfileEditMenuItemStyle> lerp(
      ThemeExtension<ProfileEditMenuItemStyle>? other, double t) {
    if (other is! ProfileEditMenuItemStyle) return this;

    return ProfileEditMenuItemStyle(
      height: lerpDouble(height, other.height, t),
      contentPadding:
          EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t),
      iconWidth: lerpDouble(iconWidth, other.iconWidth, t),
      iconTheme: IconThemeData.lerp(iconTheme, other.iconTheme, t),
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
    );
  }

  @override
  ProfileEditMenuItemStyle copyWith() => const ProfileEditMenuItemStyle();
}
