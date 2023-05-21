import 'package:flutter/material.dart';
import 'package:chat/message_menu/message_menu.dart';
import 'package:chat/styles/styles.dart';

class MessageMenu extends StatelessWidget {
  const MessageMenu({
    super.key,
    this.position,
    this.onWillPop,
    required this.items,
    required this.animation,
  });

  final Offset? position;
  final VoidCallback? onWillPop;
  final List<MessageMenuItem> items;
  final Animation<double> animation;

  static final CurveTween _tween = CurveTween(curve: Curves.ease);
  static final Animatable<double> _scale =
      Tween<double>(begin: 0.95, end: 1).chain(_tween);
  static final Animatable<Offset> _position = Tween<Offset>(
    begin: const Offset(0, -0.05),
    end: Offset.zero,
  ).chain(_tween);

  @override
  Widget build(BuildContext context) {
    final MessageMenuStyle style =
        Theme.of(context).extension<MessageMenuStyle>()!;

    final EdgeInsetsGeometry margin = EdgeInsets.only(
      top: (AppBarTheme.of(context).toolbarHeight ?? kToolbarHeight) +
          MediaQuery.of(context).viewPadding.top,
    );

    final Widget child = FadeTransition(
      opacity: _tween.animate(animation),
      child: Card(
        clipBehavior: style.clipBehavior,
        color: style.color,
        margin: margin.add(style.margin ?? EdgeInsets.zero),
        shape: style.shape,
        child: SizedBox(
          width: style.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items,
          ),
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        onWillPop?.call();
        return true;
      },
      child: CustomSingleChildLayout(
        delegate: MessageMenuRouteLayout(position),
        child: animation.status == AnimationStatus.forward
            ? ScaleTransition(
                scale: _scale.animate(animation),
                child: child,
              )
            : SlideTransition(
                position: _position.animate(animation),
                child: child,
              ),
      ),
    );
  }
}
