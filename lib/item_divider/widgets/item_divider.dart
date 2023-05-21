import 'package:flutter/material.dart';
import 'package:chat/styles/styles.dart';

class ItemDivider extends StatelessWidget {
  const ItemDivider({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    final ItemDividerStyle style =
        Theme.of(context).extension<ItemDividerStyle>()!;

    if (title == null) {
      return SizedBox(height: style.height);
    }

    return Container(
      height: style.heightWithTitle,
      alignment: style.titleAlignment,
      padding: style.titlePadding,
      child: Text(title!, style: style.titleStyle),
    );
  }
}
