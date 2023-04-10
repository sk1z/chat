import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/styles/styles.dart';

class ItemBox extends StatelessWidget {
  const ItemBox({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ItemBoxStyle style = Theme.of(context).extension<ItemBoxStyle>()!;

    return Material(
      color: style.color ?? Colors.transparent,
      elevation: style.elevation ?? 0,
      shadowColor: style.shadowColor ?? Colors.transparent,
      child: child,
    );
  }
}
