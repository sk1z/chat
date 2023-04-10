import 'package:flutter/rendering.dart';

class ProfileEditMenuRouteLayout extends SingleChildLayoutDelegate {
  const ProfileEditMenuRouteLayout(this.position);

  final Offset position;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double x = position.dx;
    double y = position.dy;

    if (x + childSize.width > size.width) {
      x = size.width - childSize.width;
    }

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(ProfileEditMenuRouteLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}
