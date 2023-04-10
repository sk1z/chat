import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/styles/profile_edit_menu_style.dart';

class ProfileEditMenu extends StatefulWidget {
  ProfileEditMenu({super.key, required this.items, required this.animation});

  final List<Widget> items;
  final Animation<double> animation;

  @override
  State<ProfileEditMenu> createState() => _ProfileEditMenuState();
}

class _ProfileEditMenuState extends State<ProfileEditMenu> {
  @override
  void initState() {
    super.initState();
    widget.animation.addStatusListener(_animationStatusChanged);
  }

  @override
  void didUpdateWidget(covariant ProfileEditMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animation != oldWidget.animation) {
      oldWidget.animation.removeStatusListener(_animationStatusChanged);
      widget.animation.addStatusListener(_animationStatusChanged);
    }
  }

  @override
  void dispose() {
    widget.animation.removeStatusListener(_animationStatusChanged);
    super.dispose();
  }

  void _animationStatusChanged(AnimationStatus status) {
    final bool menuOpens;
    if (status == AnimationStatus.forward) {
      menuOpens = true;
    } else {
      menuOpens = false;
    }
    if (menuOpens != this._menuOpens) {
      _menuOpens = menuOpens;
      setState(() {});
    }
  }

  bool _menuOpens = true;

  static final Animatable<Offset> _itemPosition = Tween<Offset>(
    begin: const Offset(0, -0.1),
    end: Offset.zero,
  );
  static final Animatable<Offset> _offset = Tween<Offset>(
    begin: const Offset(0, -8),
    end: Offset.zero,
  );
  static final CurveTween _heightWithOpacity =
      CurveTween(curve: Interval(0, 0.8));

  @override
  Widget build(BuildContext context) {
    final double unit = 1.0 / widget.items.length;
    final List<Widget> children = [];

    for (int i = 0; i < widget.items.length; i++) {
      final double start = (i + 0.65) * unit;
      final double end = (start + 2.2 * unit).clamp(0.0, 1.0);
      final CurvedAnimation animation = CurvedAnimation(
        parent: widget.animation,
        curve: Interval(start, end),
      );

      if (_menuOpens) {
        children.add(SlideTransition(
          position: _itemPosition.animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: widget.items[i],
          ),
        ));
      } else {
        children.add(widget.items[i]);
      }
    }

    final ProfileEditMenuStyle style =
        Theme.of(context).extension<ProfileEditMenuStyle>()!;

    final Widget child = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );

    final Widget card = Card(
      margin: style.margin,
      shape: style.shape,
      color: style.color,
      clipBehavior: style.clipBehavior,
      child: _menuOpens
          ? AnimatedBuilder(
              animation: widget.animation,
              builder: (BuildContext context, Widget? child) {
                return Align(
                  alignment: Alignment.topRight,
                  widthFactor: 1,
                  heightFactor: _heightWithOpacity.evaluate(widget.animation),
                  child: child,
                );
              },
              child: child,
            )
          : child,
    );

    return FadeTransition(
      opacity: _heightWithOpacity.animate(widget.animation),
      child: !_menuOpens
          ? AnimatedBuilder(
              animation: widget.animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: _offset.evaluate(widget.animation),
                  child: child,
                );
              },
              child: card,
            )
          : card,
    );
  }
}
