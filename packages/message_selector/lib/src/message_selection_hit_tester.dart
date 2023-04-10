import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'message_selection_types.dart';

class MessageSelectionHitTester extends SingleChildRenderObjectWidget {
  const MessageSelectionHitTester({super.key, required super.child});

  @override
  RenderMessageSelectionHitTester createRenderObject(BuildContext context) =>
      RenderMessageSelectionHitTester();
}

class RenderMessageSelectionHitTester extends RenderProxyBox {
  MessageHitData? hitTestAt(Offset localPosition, Offset globalPosition) {
    final result = BoxHitTestResult();
    final hit =
        hitTestChildren(result, position: _withinPaintBounds(localPosition));
    if (hit) {
      for (final entry in result.path) {
        final target = entry.target;
        if (target is RenderMetaData) {
          final metaData = target.metaData;
          if (metaData is MessageSelectionMetaData) {
            return MessageHitData(metaData.messageId, globalPosition);
          }
        }
      }
    }
    return null;
  }

  Offset _withinPaintBounds(Offset position) {
    double clamp(double val, double a, double b) {
      return max(a, min(val, b));
    }

    return Offset(
      clamp(position.dx, paintBounds.left + 1, paintBounds.right - 1),
      clamp(position.dy, paintBounds.top + 1, paintBounds.bottom - 1),
    );
  }
}
