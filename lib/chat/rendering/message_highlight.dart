import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class RenderMessageHighlight extends RenderProxyBox {
  RenderMessageHighlight(this.radiusFactor, Color? color) : _color = color;

  Animation<double> radiusFactor;
  Offset? _hitPosition, _highlightPosition;
  Color? _color;
  double _midWidth = 0, _midHeight = 0;
  Size _sizeWithIncreasedHeight = Size.zero;
  double _defaultTargetRadius = 0, _positionShift = 0, _targetRadius = 0;

  set hitPosition(Offset? value) {
    if (_hitPosition == value) return;
    _hitPosition = value;
    _highlightPosition =
        value == null ? null : _withinPaintBounds(globalToLocal(_hitPosition!));
    _updateRadiusSizeWithPositionShift();
  }

  set color(Color? value) {
    if (_color == value) return;
    _color = value;
    markNeedsPaint();
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    radiusFactor.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    radiusFactor.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  void performLayout() {
    super.performLayout();
    if (child != null) {
      _midWidth = child!.size.width / 2;
      _midHeight = child!.size.height / 2;
      _sizeWithIncreasedHeight =
          Size(child!.size.width, child!.size.height + 1);
      _defaultTargetRadius = (child!.size.center(Offset.zero) -
              _sizeWithIncreasedHeight.topLeft(Offset.zero))
          .distance;
      _updateRadiusSizeWithPositionShift();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final position = _highlightPosition == null
        ? Offset(_midWidth, _midHeight)
        : Offset(
            _highlightPosition!.dx + _positionShift * radiusFactor.value,
            _highlightPosition!.dy,
          );

    final paint = Paint();
    if (_color != null) paint.color = _color!;

    final canvas = context.canvas;
    canvas.clipRect(Rect.fromLTRB(0, -0.5, size.width, size.height + 0.5));
    canvas.drawCircle(position, _targetRadius * radiusFactor.value, paint);

    super.paint(context, offset);
  }

  void _updateRadiusSizeWithPositionShift() {
    if (_highlightPosition == null) {
      _positionShift = 0;
      _targetRadius = _defaultTargetRadius;
      return;
    }
    _positionShift = (_midWidth - _highlightPosition!.dx) * 0.75;
    _targetRadius = _getHighlightRadiusForPositionInSize(
        _sizeWithIncreasedHeight,
        Offset(
          _highlightPosition!.dx + _positionShift,
          _highlightPosition!.dy + 0.5,
        ));
  }

  Offset _withinPaintBounds(Offset position) {
    double clamp(double val, double a, double b) {
      return math.max(a, math.min(val, b));
    }

    return Offset(
      clamp(position.dx, paintBounds.left + 1, paintBounds.right - 1),
      clamp(position.dy, paintBounds.top + 1, paintBounds.bottom - 1),
    );
  }

  double _getHighlightRadiusForPositionInSize(Size bounds, Offset position) {
    final double d1 = (position - bounds.topLeft(Offset.zero)).distance;
    final double d2 = (position - bounds.topRight(Offset.zero)).distance;
    final double d3 = (position - bounds.bottomLeft(Offset.zero)).distance;
    final double d4 = (position - bounds.bottomRight(Offset.zero)).distance;
    return math.max(math.max(d1, d2), math.max(d3, d4)).ceilToDouble();
  }

  @override
  bool hitTestSelf(Offset position) {
    return size.contains(position);
  }
}
