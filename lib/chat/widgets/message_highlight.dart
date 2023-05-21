import 'package:flutter/widgets.dart';
import 'package:chat/chat/chat.dart';

class MessageHighlight extends SingleChildRenderObjectWidget {
  const MessageHighlight(
      {super.child, required this.radius, this.hitPosition, this.color});

  final Animation<double> radius;
  final Offset? hitPosition;
  final Color? color;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMessageHighlight(radius, color);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderMessageHighlight renderObject) {
    renderObject
      ..hitPosition = hitPosition
      ..color = color;
  }
}
