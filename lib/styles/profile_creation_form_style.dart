import 'package:flutter/material.dart';

class ProfileCreationFormStyle
    extends ThemeExtension<ProfileCreationFormStyle> {
  const ProfileCreationFormStyle({this.padding});

  final EdgeInsetsGeometry? padding;

  @override
  ThemeExtension<ProfileCreationFormStyle> lerp(
      ThemeExtension<ProfileCreationFormStyle>? other, double t) {
    if (other is! ProfileCreationFormStyle) return this;

    return ProfileCreationFormStyle(
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
    );
  }

  @override
  ProfileCreationFormStyle copyWith() => const ProfileCreationFormStyle();
}
