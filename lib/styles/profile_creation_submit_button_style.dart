import 'package:flutter/material.dart';

class ProfileCreationSubmitButtonStyle
    extends ThemeExtension<ProfileCreationSubmitButtonStyle> {
  const ProfileCreationSubmitButtonStyle({this.iconTheme});

  final IconThemeData? iconTheme;

  @override
  ThemeExtension<ProfileCreationSubmitButtonStyle> lerp(
      ThemeExtension<ProfileCreationSubmitButtonStyle>? other, double t) {
    if (other is! ProfileCreationSubmitButtonStyle) return this;

    return ProfileCreationSubmitButtonStyle(
      iconTheme: IconThemeData.lerp(iconTheme, other.iconTheme, t),
    );
  }

  @override
  ProfileCreationSubmitButtonStyle copyWith() =>
      const ProfileCreationSubmitButtonStyle();
}
