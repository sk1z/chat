import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class ItemBoxStyle extends ThemeExtension<ItemBoxStyle> {
  const ItemBoxStyle({
    this.color,
    this.elevation,
    this.shadowColor,
  });

  final Color? color;
  final double? elevation;
  final Color? shadowColor;

  @override
  ThemeExtension<ItemBoxStyle> lerp(
      ThemeExtension<ItemBoxStyle>? other, double t) {
    if (other is! ItemBoxStyle) return this;

    return ItemBoxStyle(
      color: Color.lerp(color, other.color, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
    );
  }

  @override
  ItemBoxStyle copyWith() => ItemBoxStyle();
}
