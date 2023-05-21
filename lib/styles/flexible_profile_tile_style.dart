import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class FlexibleProfileTileStyle
    extends ThemeExtension<FlexibleProfileTileStyle> {
  const FlexibleProfileTileStyle({
    this.expandedHeight,
    this.contentPadding,
    this.avatarColor,
    this.avatarWidth,
    this.avatarSize,
    this.avatarTextStyle,
    this.nameHeight,
    this.nameStyle,
    this.onlinePadding,
    this.onlineStyle,
    this.expandedContentPadding,
    this.expandedAvatarWidth,
    this.expandedAvatarSize,
    this.expandedAvatarTextStyle,
    this.expandedNameHeight,
    this.expandedNameStyle,
    this.expandedOnlinePadding,
  });

  final double? expandedHeight;
  final EdgeInsetsGeometry? contentPadding;
  final Color? avatarColor;
  final double? avatarWidth;
  final double? avatarSize;
  final TextStyle? avatarTextStyle;
  final double? nameHeight;
  final TextStyle? nameStyle;
  final EdgeInsetsGeometry? onlinePadding;
  final TextStyle? onlineStyle;
  final EdgeInsetsGeometry? expandedContentPadding;
  final double? expandedAvatarWidth;
  final double? expandedAvatarSize;
  final TextStyle? expandedAvatarTextStyle;
  final double? expandedNameHeight;
  final TextStyle? expandedNameStyle;
  final EdgeInsetsGeometry? expandedOnlinePadding;

  @override
  ThemeExtension<FlexibleProfileTileStyle> lerp(
      ThemeExtension<FlexibleProfileTileStyle>? other, double t) {
    if (other is! FlexibleProfileTileStyle) return this;

    return FlexibleProfileTileStyle(
      expandedHeight: lerpDouble(expandedHeight, other.expandedHeight, t),
      contentPadding:
          EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t),
      avatarColor: Color.lerp(avatarColor, other.avatarColor, t),
      avatarWidth: lerpDouble(avatarWidth, other.avatarWidth, t),
      avatarSize: lerpDouble(avatarSize, other.avatarSize, t),
      avatarTextStyle:
          TextStyle.lerp(avatarTextStyle, other.avatarTextStyle, t),
      nameHeight: lerpDouble(nameHeight, other.nameHeight, t),
      nameStyle: TextStyle.lerp(nameStyle, other.nameStyle, t),
      onlinePadding:
          EdgeInsetsGeometry.lerp(onlinePadding, other.onlinePadding, t),
      onlineStyle: TextStyle.lerp(onlineStyle, other.onlineStyle, t),
      expandedContentPadding: EdgeInsetsGeometry.lerp(
          expandedContentPadding, other.expandedContentPadding, t),
      expandedAvatarWidth:
          lerpDouble(expandedAvatarWidth, other.expandedAvatarWidth, t),
      expandedAvatarSize:
          lerpDouble(expandedAvatarSize, other.expandedAvatarSize, t),
      expandedAvatarTextStyle: TextStyle.lerp(
          expandedAvatarTextStyle, other.expandedAvatarTextStyle, t),
      expandedNameHeight:
          lerpDouble(expandedNameHeight, other.expandedNameHeight, t),
      expandedNameStyle:
          TextStyle.lerp(expandedNameStyle, other.expandedNameStyle, t),
      expandedOnlinePadding: EdgeInsetsGeometry.lerp(
          expandedOnlinePadding, other.expandedOnlinePadding, t),
    );
  }

  @override
  FlexibleProfileTileStyle copyWith() => FlexibleProfileTileStyle();
}
