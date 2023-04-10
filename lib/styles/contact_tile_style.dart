import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class ContactTileStyle extends ThemeExtension<ContactTileStyle> {
  const ContactTileStyle({
    this.height,
    this.contentPadding,
    this.avatarColor,
    this.avatarWidth,
    this.avatarSize,
    this.avatarTextStyle,
    this.nameStyle,
    this.nameHeight,
    this.lastSeenPadding,
    this.lastSeenStyle,
    this.onlineStyle,
    this.appBarContentPadding,
    this.appBarAvatarWidth,
    this.appBarAvatarSize,
    this.appBarAvatarTextStyle,
    this.appBarNameStyle,
    this.appBarNameHeight,
    this.appBarLastSeenPadding,
  });

  final double? height;
  final EdgeInsetsGeometry? contentPadding;
  final Color? avatarColor;
  final double? avatarWidth;
  final double? avatarSize;
  final TextStyle? avatarTextStyle;
  final TextStyle? nameStyle;
  final double? nameHeight;
  final EdgeInsetsGeometry? lastSeenPadding;
  final TextStyle? lastSeenStyle;
  final TextStyle? onlineStyle;
  final EdgeInsetsGeometry? appBarContentPadding;
  final double? appBarAvatarWidth;
  final double? appBarAvatarSize;
  final TextStyle? appBarAvatarTextStyle;
  final TextStyle? appBarNameStyle;
  final double? appBarNameHeight;
  final EdgeInsetsGeometry? appBarLastSeenPadding;

  @override
  ThemeExtension<ContactTileStyle> lerp(
      ThemeExtension<ContactTileStyle>? other, double t) {
    if (other is! ContactTileStyle) return this;

    return ContactTileStyle(
      height: lerpDouble(height, other.height, t),
      contentPadding:
          EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t),
      avatarColor: Color.lerp(avatarColor, other.avatarColor, t),
      avatarWidth: lerpDouble(avatarWidth, other.avatarWidth, t),
      avatarSize: lerpDouble(avatarSize, other.avatarSize, t),
      avatarTextStyle:
          TextStyle.lerp(avatarTextStyle, other.avatarTextStyle, t),
      nameStyle: TextStyle.lerp(nameStyle, other.nameStyle, t),
      nameHeight: lerpDouble(nameHeight, other.nameHeight, t),
      lastSeenPadding:
          EdgeInsetsGeometry.lerp(lastSeenPadding, other.lastSeenPadding, t),
      lastSeenStyle: TextStyle.lerp(lastSeenStyle, other.lastSeenStyle, t),
      onlineStyle: TextStyle.lerp(onlineStyle, other.onlineStyle, t),
      appBarContentPadding: EdgeInsetsGeometry.lerp(
          appBarContentPadding, other.appBarContentPadding, t),
      appBarAvatarWidth:
          lerpDouble(appBarAvatarWidth, other.appBarAvatarWidth, t),
      appBarAvatarSize: lerpDouble(appBarAvatarSize, other.appBarAvatarSize, t),
      appBarAvatarTextStyle:
          TextStyle.lerp(appBarAvatarTextStyle, other.appBarAvatarTextStyle, t),
      appBarNameStyle:
          TextStyle.lerp(appBarNameStyle, other.appBarNameStyle, t),
      appBarNameHeight: lerpDouble(appBarNameHeight, other.appBarNameHeight, t),
      appBarLastSeenPadding: EdgeInsetsGeometry.lerp(
          appBarLastSeenPadding, other.appBarLastSeenPadding, t),
    );
  }

  @override
  ContactTileStyle copyWith() => ContactTileStyle();
}
