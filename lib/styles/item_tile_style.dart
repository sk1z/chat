import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class ItemTileStyle extends ThemeExtension<ItemTileStyle> {
  const ItemTileStyle({
    this.height,
    this.heightWithSubtitle,
    this.contentPadding,
    this.iconWidth,
    this.iconTheme,
    this.titleHeight,
    this.titleHeightWithSubtitle,
    this.titleStyle,
    this.subtitlePadding,
    this.subtitleStyle,
    this.accentIconWidth,
    this.accentIconTheme,
    this.accentTitleStyle,
    this.dividerColor,
    this.dividerHeight,
    this.dividerIndent,
  });

  final double? height;
  final double? heightWithSubtitle;
  final EdgeInsetsGeometry? contentPadding;
  final double? iconWidth;
  final IconThemeData? iconTheme;
  final double? titleHeight;
  final double? titleHeightWithSubtitle;
  final TextStyle? titleStyle;
  final double? subtitlePadding;
  final TextStyle? subtitleStyle;
  final double? accentIconWidth;
  final IconThemeData? accentIconTheme;
  final TextStyle? accentTitleStyle;
  final Color? dividerColor;
  final double? dividerHeight;
  final double? dividerIndent;

  @override
  ThemeExtension<ItemTileStyle> lerp(
      ThemeExtension<ItemTileStyle>? other, double t) {
    if (other is! ItemTileStyle) return this;

    return ItemTileStyle(
      height: lerpDouble(height, other.height, t),
      heightWithSubtitle:
          lerpDouble(heightWithSubtitle, other.heightWithSubtitle, t),
      contentPadding:
          EdgeInsetsGeometry.lerp(contentPadding, other.contentPadding, t),
      iconWidth: lerpDouble(iconWidth, other.iconWidth, t),
      iconTheme: IconThemeData.lerp(iconTheme, other.iconTheme, t),
      titleHeight: lerpDouble(titleHeight, other.titleHeight, t),
      titleHeightWithSubtitle:
          lerpDouble(titleHeightWithSubtitle, other.titleHeightWithSubtitle, t),
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
      subtitlePadding: lerpDouble(subtitlePadding, other.subtitlePadding, t),
      subtitleStyle: TextStyle.lerp(subtitleStyle, other.subtitleStyle, t),
      accentIconWidth: lerpDouble(accentIconWidth, other.accentIconWidth, t),
      accentIconTheme:
          IconThemeData.lerp(accentIconTheme, other.accentIconTheme, t),
      accentTitleStyle:
          TextStyle.lerp(accentTitleStyle, other.accentTitleStyle, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      dividerHeight: lerpDouble(dividerHeight, other.dividerHeight, t),
      dividerIndent: lerpDouble(dividerIndent, other.dividerIndent, t),
    );
  }

  @override
  ItemTileStyle copyWith() => ItemTileStyle();
}
