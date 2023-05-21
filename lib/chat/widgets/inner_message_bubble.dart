import 'package:flutter/material.dart';
import 'package:chat/chat/chat.dart';

class InnerMessageBubble extends SingleChildRenderObjectWidget {
  const InnerMessageBubble({
    super.child,
    required this.text,
    required this.textDirection,
    required this.maxWidthPercentage,
    required this.maxWidth,
  });

  final InlineSpan text;
  final TextDirection textDirection;
  final double maxWidthPercentage;
  final double maxWidth;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderInnerChatBubble(
        text, textDirection, maxWidthPercentage, maxWidth);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderInnerChatBubble renderObject) {
    renderObject
      ..text = text
      ..textDirection = textDirection
      ..maxWidthPercentage = maxWidthPercentage
      ..maxWidth = maxWidth;
  }
}
