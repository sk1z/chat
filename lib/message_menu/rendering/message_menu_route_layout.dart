import 'package:flutter/rendering.dart';

class MessageMenuRouteLayout extends SingleChildLayoutDelegate {
  const MessageMenuRouteLayout(this.position);

  final Offset? position;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final Offset position = this.position ??
        Offset(
          size.width / 2,
          size.height / 2,
        );

    double x = position.dx - childSize.width / 2;
    double y = position.dy - childSize.height / 2;

    if (x < 0) {
      x = 0;
    } else if (x + childSize.width > size.width) {
      x = size.width - childSize.width;
    }
    if (y < 0) {
      y = 0;
    } else if (y + childSize.height > size.height) {
      y = size.height - childSize.height;
    }

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(MessageMenuRouteLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}
