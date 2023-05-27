import 'package:flutter/material.dart';

class ProfileEditMenuStyle extends ThemeExtension<ProfileEditMenuStyle> {
  const ProfileEditMenuStyle({
    this.margin,
    this.shape,
    this.color,
    this.clipBehavior,
  });

  final EdgeInsetsGeometry? margin;
  final ShapeBorder? shape;
  final Color? color;
  final Clip? clipBehavior;

  @override
  ThemeExtension<ProfileEditMenuStyle> lerp(
      ThemeExtension<ProfileEditMenuStyle>? other, double t) {
    if (other is! ProfileEditMenuStyle) return this;

    return ProfileEditMenuStyle(
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      shape: ShapeBorder.lerp(shape, other.shape, t),
      color: Color.lerp(color, other.color, t),
      clipBehavior: t < 0.5 ? clipBehavior : other.clipBehavior,
    );
  }

  @override
  ProfileEditMenuStyle copyWith() => const ProfileEditMenuStyle();
}
