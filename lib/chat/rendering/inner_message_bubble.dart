import 'dart:math' as math;

import 'package:flutter/rendering.dart';

class RenderInnerMessageBubble extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  RenderInnerMessageBubble(
    InlineSpan text,
    TextDirection textDirection,
    double maxWidthPercentage,
    double maxWidth,
  )   : _textPainter = TextPainter(
          text: text,
          textDirection: textDirection,
        ),
        _maxWidthPercentage = maxWidthPercentage,
        _maxWidth = maxWidth;

  final TextPainter _textPainter;
  double _maxWidthPercentage;
  double _maxWidth;

  set text(InlineSpan value) {
    switch (_textPainter.text!.compareTo(value)) {
      case RenderComparison.identical:
      case RenderComparison.metadata:
        return;
      case RenderComparison.paint:
      case RenderComparison.layout:
        _textPainter.text = value;
        markNeedsLayout();
        break;
    }
  }

  set textDirection(TextDirection value) {
    if (_textPainter.textDirection == value) return;
    _textPainter.textDirection = value;
    markNeedsLayout();
  }

  set maxWidthPercentage(double value) {
    if (_maxWidthPercentage == value) return;
    _maxWidthPercentage = value;
    markNeedsLayout();
  }

  set maxWidth(double value) {
    if (_maxWidth == value) return;
    _maxWidth = value;
    markNeedsLayout();
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _performLayout(constraints: constraints, dry: true);
  }

  @override
  void performLayout() {
    size = _performLayout(constraints: constraints, dry: false);
    if (child != null) {
      final childParentData = child!.parentData as BoxParentData;
      childParentData.offset = Offset(
        size.width - child!.size.width,
        size.height - child!.size.height,
      );
    }
  }

  Size _performLayout(
      {required BoxConstraints constraints, required bool dry}) {
    final maxWidth = math.min(
      _maxWidth * _maxWidthPercentage / 100,
      constraints.maxWidth,
    );

    _textPainter.layout(maxWidth: maxWidth);
    double width = _textPainter.width;
    double height = _textPainter.height;

    if (child != null) {
      final Size childSize;

      constraints = constraints.copyWith(maxWidth: maxWidth);
      if (!dry) {
        child!.layout(constraints, parentUsesSize: true);
        childSize = child!.size;
      } else {
        childSize = child!.getDryLayout(constraints);
      }

      final lines = _textPainter.computeLineMetrics();
      final lastLineWidth = lines.last.width;
      final horizontalSpaceExceeded =
          lastLineWidth + childSize.width > maxWidth;

      if (horizontalSpaceExceeded) {
        height += childSize.height;
      } else {
        if (lines.length == 1) {
          width += childSize.width;
        } else {
          width = math.max(width, lastLineWidth + childSize.width);
        }
        height -= lines.last.descent;
        height += childSize.height / 2;
      }
    }

    return Size(width, height);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _textPainter.paint(context.canvas, offset);
    if (child != null) {
      final parentData = child!.parentData as BoxParentData;
      context.paintChild(child!, offset + parentData.offset);
    }
  }
}
