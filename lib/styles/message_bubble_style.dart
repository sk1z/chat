import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class MessageBubbleStyle extends ThemeExtension<MessageBubbleStyle> {
  const MessageBubbleStyle({
    this.margin,
    this.padding,
    this.messageLastUpdatedPadding,
    this.borderRadius,
    this.myMessageColor,
    this.contactMessageColor,
    this.myMessageHighlightColor,
    this.contactMessageHighlightColor,
    this.messageContentStyle,
    this.myMessageLastUpdateStyle,
    this.contactMessageLastUpdateStyle,
    this.maxWidthPercentage,
  });

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? messageLastUpdatedPadding;
  final double? borderRadius;
  final Color? myMessageColor;
  final Color? contactMessageColor;
  final Color? myMessageHighlightColor;
  final Color? contactMessageHighlightColor;
  final TextStyle? messageContentStyle;
  final TextStyle? myMessageLastUpdateStyle;
  final TextStyle? contactMessageLastUpdateStyle;
  final double? maxWidthPercentage;

  @override
  ThemeExtension<MessageBubbleStyle> lerp(
      ThemeExtension<MessageBubbleStyle>? other, double t) {
    if (other is! MessageBubbleStyle) return this;

    return MessageBubbleStyle(
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      messageLastUpdatedPadding: EdgeInsetsGeometry.lerp(
          messageLastUpdatedPadding, other.messageLastUpdatedPadding, t),
      borderRadius: ui.lerpDouble(borderRadius, other.borderRadius, t),
      myMessageColor: Color.lerp(myMessageColor, other.myMessageColor, t),
      contactMessageColor:
          Color.lerp(contactMessageColor, other.contactMessageColor, t),
      myMessageHighlightColor:
          Color.lerp(myMessageHighlightColor, other.myMessageHighlightColor, t),
      contactMessageHighlightColor: Color.lerp(
          contactMessageHighlightColor, other.contactMessageHighlightColor, t),
      messageContentStyle:
          TextStyle.lerp(messageContentStyle, other.messageContentStyle, t),
      myMessageLastUpdateStyle: TextStyle.lerp(
          myMessageLastUpdateStyle, other.myMessageLastUpdateStyle, t),
      contactMessageLastUpdateStyle: TextStyle.lerp(
          contactMessageLastUpdateStyle,
          other.contactMessageLastUpdateStyle,
          t),
      maxWidthPercentage:
          ui.lerpDouble(maxWidthPercentage, other.maxWidthPercentage, t),
    );
  }

  @override
  MessageBubbleStyle copyWith() => MessageBubbleStyle();
}
