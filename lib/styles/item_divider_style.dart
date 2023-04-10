import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class ItemDividerStyle extends ThemeExtension<ItemDividerStyle> {
  const ItemDividerStyle({
    this.height,
    this.heightWithTitle,
    this.titleAlignment,
    this.titlePadding,
    this.titleStyle,
  });

  final double? height;
  final double? heightWithTitle;
  final Alignment? titleAlignment;
  final EdgeInsetsGeometry? titlePadding;
  final TextStyle? titleStyle;

  @override
  ThemeExtension<ItemDividerStyle> lerp(
      ThemeExtension<ItemDividerStyle>? other, double t) {
    if (other is! ItemDividerStyle) return this;

    return ItemDividerStyle(
      height: lerpDouble(height, other.height, t),
      heightWithTitle: lerpDouble(heightWithTitle, other.heightWithTitle, t),
      titleAlignment: Alignment.lerp(titleAlignment, other.titleAlignment, t),
      titlePadding:
          EdgeInsetsGeometry.lerp(titlePadding, other.titlePadding, t),
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
    );
  }

  @override
  ItemDividerStyle copyWith() => ItemDividerStyle();
}
