import 'package:flutter/material.dart';

class ProfileCreationPageStyle
    extends ThemeExtension<ProfileCreationPageStyle> {
  const ProfileCreationPageStyle({this.backgroundColor});

  final Color? backgroundColor;

  @override
  ThemeExtension<ProfileCreationPageStyle> lerp(
      ThemeExtension<ProfileCreationPageStyle>? other, double t) {
    if (other is! ProfileCreationPageStyle) return this;

    return ProfileCreationPageStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
    );
  }

  @override
  ProfileCreationPageStyle copyWith() => ProfileCreationPageStyle();
}
