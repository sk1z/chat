import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/styles/styles.dart';

enum HeaderMode { tight, wide }

class Header extends StatelessWidget {
  const Header({
    required this.title,
    this.mode = HeaderMode.tight,
  });

  final String title;
  final HeaderMode mode;

  @override
  Widget build(BuildContext context) {
    final HeaderStyle style = Theme.of(context).extension<HeaderStyle>()!;

    final double? height;
    final EdgeInsetsGeometry? titlePadding;

    switch (mode) {
      case HeaderMode.tight:
        height = style.height;
        titlePadding = style.titlePadding;
        break;
      case HeaderMode.wide:
        height = style.wideHeight ?? style.height;
        titlePadding = style.wideTitlePadding ?? style.titlePadding;
        break;
    }

    return Container(
      alignment: Alignment.topLeft,
      height: height,
      padding: titlePadding,
      child: Container(
        alignment: Alignment.bottomLeft,
        height: style.titleHeight,
        child: Text(title, style: style.titleStyle),
      ),
    );
  }
}
